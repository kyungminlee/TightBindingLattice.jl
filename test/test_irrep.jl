using Test
using TightBindingLattice

@testset "irrep" begin

    unitcell = make_unitcell([1.0 0.0; 0.0 1.0]; OrbitalType=String)
    addorbital!(unitcell, "Ox", FractCoord([0,0], [0.5, 0.0]))
    addorbital!(unitcell, "Oy", FractCoord([0,0], [0.0, 0.5]))

    lattice = make_lattice(unitcell, [4 0; 0 4])
    tsym = TranslationSymmetry(lattice)
    psym = project(PointSymmetryDatabase.get(13), [1 0 0; 0 1 0])

    @testset "translation" begin
        @test_throws ArgumentError TranslationSymmetryIrrepComponent(tsym, 99999)
        @test_throws ArgumentError TranslationSymmetryIrrepComponent(tsym, 1, 2)

        for tsym_irrep in 1:num_irreps(tsym)
            tsic = TranslationSymmetryIrrepComponent(tsym, tsym_irrep)
            @test group_order(tsic) == group_order(tsym)
            psym_little = little_symmetry(tsic, psym)

            k = tsym.hypercube.coordinates[tsym_irrep]
            @test iscompatible(tsym, tsym_irrep, psym) == (k in [[0,0], [2,2]])
            @test iscompatible(tsym, tsym_irrep, psym_little)
            lg_matrep = psym.matrix_representations[little_group_elements(tsym, tsym_irrep, psym)]
            @test !isnothing(group_isomorphism(little_group(tsym, tsym_irrep, psym),
                                                                                  FiniteGroup(group_multiplication_table(lg_matrep))))
            let psic = PointSymmetryIrrepComponent(psym, 1, 1)
                if k in [[0,0], [2,2]]
                    SymmorphicSpaceSymmetryIrrepComponent(tsic, psic)
                else
                    @test_throws ArgumentError SymmorphicSpaceSymmetryIrrepComponent(tsic, psic)
                end
            end
        end # for tsym_irrep

        for tsic in get_irrep_components(lattice, tsym)
            k = tsym.hypercube.coordinates[tsic.irrep_index]
            psym_little = little_symmetry(tsic, psym)

            @test iscompatible(tsic, psym) == (k in [[0,0], [2,2]])
            @test iscompatible(tsic, psym_little)
            lg_matrep = psym.matrix_representations[little_group_elements(tsic, psym)]
            @test !isnothing(group_isomorphism(little_group(tsic, psym),
                             FiniteGroup(group_multiplication_table(lg_matrep))))
            let psic = PointSymmetryIrrepComponent(psym, 1, 1)
                if k in [[0,0], [2,2]]
                    SymmorphicSpaceSymmetryIrrepComponent(tsic, psic)
                else
                    @test_throws ArgumentError SymmorphicSpaceSymmetryIrrepComponent(tsic, psic)
                end
            end
        end
    end

    @testset "point" begin
        @test_throws ArgumentError PointSymmetryIrrepComponent(psym, 99999, 1)
        @test_throws ArgumentError PointSymmetryIrrepComponent(psym, 1, 10)
        @test length(collect(get_irrep_components(lattice, psym))) == 1 + 1 + 1 + 1 + 2
        for psic in get_irrep_components(lattice, psym)
            @test group_order(psic) == group_order(psym)

            permphase = collect(get_irrep_iterator(lattice, psic))
            @test length(permphase) == group_order(psym)

            perms = [p for (p, ϕ) in permphase]
            @test ishomomorphic(psym.group, perms)

            mtab = group_multiplication_table(perms)
            @test mtab == psym.group.multiplication_table
        end
    end

    @testset "space" begin
        ssics1 = []
        for tsic in get_irrep_components(lattice, tsym)
            psym_little = little_symmetry(tsic, psym)
            for psic in get_irrep_components(lattice, psym_little)
                push!(ssics1, (tsic, psic))
            end
        end
        ssics2 = []
        for ssic in get_irrep_components(lattice, tsym, psym)
            push!(ssics2, ssic)
        end
        @test length(ssics1) == length(ssics2)
        for ((tsic, psic), ssic) in zip(ssics1, ssics2)
            @test group_order(ssic) == group_order(tsic) * group_order(psic)

            @test tsic.symmetry.hypercube == ssic.translation.symmetry.hypercube
            @test psic.symmetry.hermann_mauguinn == ssic.point.symmetry.hermann_mauguinn
            @test tsic.irrep_index == ssic.translation.irrep_index
            @test psic.irrep_index == ssic.point.irrep_index
            @test tsic.irrep_component == ssic.translation.irrep_component
            @test psic.irrep_component == ssic.point.irrep_component

            @test sum(1 for x in collect(get_irrep_iterator(lattice, ssic))) == group_order(tsic) * group_order(psic)
        end
    end


end # testset little_symmetry

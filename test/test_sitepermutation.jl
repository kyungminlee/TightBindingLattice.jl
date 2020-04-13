using Test
using TightBindingLattice


@testset "sitepermutation" begin
    op1 = SitePermutation([3,1,2]) # 1=>3, 2=>1, 3=>2
    op2 = SitePermutation([2,1,3]) # 1=>2, 2=>1, 3=>3
    @test op2 * op1 != SitePermutation([1,2,3])
    @test op2 * op1 == SitePermutation([3,2,1])


    @testset "kagome" begin
        include("Kagome.jl")
        kagome = make_kagome_lattice([3 0; 0 3])
        t1 = TranslationOperation([1, 0])
        t1e = embed(kagome.lattice, t1)
        t2 = TranslationOperation([0, 1])
        t2e = embed(kagome.lattice, t2)
        # @show t1e
        # @show t2e

        psym = project(PointSymmetryDatabase.get(25), [1 0 0; 0 1 0])
        p6 = psym.elements[6]
        p6e = embed(kagome.lattice, p6)
        # @show p6e
    end

end
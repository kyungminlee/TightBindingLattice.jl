using Test
using LinearAlgebra
using YAML


@testset "PointSymmetry" begin
  # D_4
  file_path = abspath(@__DIR__, "..", "data", "PointGroup3D", "PointGroup3D-12.yaml")
  data_yaml = YAML.load_file(file_path)

  let data_yaml_2 = deepcopy(data_yaml)
    data_yaml_2["Generators"] = [1]
    @test_throws ArgumentError PointSymmetry(data_yaml_2)
  end

  psym = PointSymmetry(data_yaml)
  @test group_order(psym) == 8
  let elnames = element_names(psym)
    for i in 1:8
      @test elnames[i] == element_name(psym, i)
    end
  end
  ord_group = group_order(psym.group)

  @testset "generators" begin
    # Generators completely generate the group
    @test generate_subgroup(psym.group, psym.generators) == BitSet(1:ord_group)
    @test prod(psym.group.period_lengths[x] for x in psym.generators) != ord_group # nonabelian
  end

  @testset "multiplication table" begin
    matrep_lookup = Dict(m=>i for (i, m) in enumerate(psym.matrix_representations))
    matrep_mtab = zeros(Int, (ord_group, ord_group))
    for i1 in 1:ord_group, i2 in 1:ord_group
      m1 = psym.matrix_representations[i1]
      m2 = psym.matrix_representations[i2]
      m3 = m1 * m2
      i3 = matrep_lookup[m3]
      matrep_mtab[i1, i2] = i3
    end
    @test matrep_mtab == psym.group.multiplication_table
  end


  @test num_irreps(psym) == 5

  let χ = [1  1  1  1  1;
           1  1  1 -1 -1;
           1  1 -1 -1  1;
           1  1 -1  1 -1;
           2 -2  0  0  0]
    @test character_table(psym) ≈ χ
    @test size(character_table(psym)) == (5, 5)
  end

  @test length(irreps(psym)) == 5
  for i in 1:5
    @test irreps(psym)[i] == irrep(psym, i)
  end

  for (idx_irrep, irrep) in enumerate(irreps(psym)), m in irrep.matrices
    d = psym.character_table[idx_irrep, 1]
    @test size(m) == (d, d)
  end




  hc1 = HypercubicLattice([4 0; 0 4])
  hc2 = HypercubicLattice([4 0; 0 3])
  tsym1 = TranslationSymmetry(hc1)
  tsym2 = TranslationSymmetry(hc2)

  @test_throws DimensionMismatch iscompatible(hc1, psym)
  @test_throws DimensionMismatch iscompatible(tsym1, psym)

  psym_proj = project(psym, [1 0 0; 0 1 0])

  @test iscompatible(hc1, psym_proj)
  @test !iscompatible(hc2, psym_proj)
  @test iscompatible(tsym1, psym_proj)
  @test !iscompatible(tsym2, psym_proj)

end # @testset "PointSymmetry"





#
# @testset "translation" begin
#   @testset "constructor exceptions" begin
#     @test_throws ArgumentError TranslationGroup([Permutation([2,3,4,1]), Permutation([3,4,1,2])])
#     @test_throws ArgumentError TranslationGroup([Permutation([2,1,3,4]), Permutation([1,3,2,4])])
#   end
#
#   t1 = Permutation([2,3,1, 5,6,4])
#   t2 = Permutation([4,5,6, 1,2,3])
#   g = TranslationGroup([t1, t2])
#
#   @test g.generators == [t1, t2]
#   @test g.translations == [[0,0], [1,0], [2,0], [0,1], [1,1], [2,1]]
#   @test Set(g.elements) == Set([t1^d1*t2^d2 for d1 in 0:2 for d2 in 0:1])
#   @test length(Set(g.elements)) == 2*3
#   @test g.fractional_momenta == [[0//3, 0//2], [1//3, 0//2], [2//3, 0//2],
#                                  [0//3, 1//2], [1//3, 1//2], [2//3, 1//2]]
#   χ = [cis(-2π * (k ⋅ t)) for k in g.fractional_momenta, t in g.translations]
#   @test isapprox(g.character_table, χ; atol=sqrt(eps(Float64)))
#
#   @test is_compatible([0//1, 0//1], [0,0])
#   @test !is_compatible([0//1, 1//2], [0,1])
#
#   @test is_compatible([0//1, 0//1], [[0,0]])
#   @test !is_compatible([0//1, 1//2], [[0,0], [0,1]])
# end
#
#
# @testset "non-orthogonal" begin
#   #=
#   . . . o .
#   o . . . .
#   . . . . o
#   . o . . .
#
#   2 3 4 1 5
#   1|5 6 7|2
#   7|2 3 4|1
#   4|1|5 6 7
#
#
#   =#
#   t1 = Permutation([5,3,4,1,6,7,2])
#   t2 = Permutation([2,5,6,7,3,4,1])
#   generators = [t1, t2]
#   #translation_group = TranslationGroup(t1, t2)
#   full_shape = [g.order for g in generators]
#   full_translations = vcat( collect( Iterators.product([0:g.order-1 for g in generators]...) )...)
#   full_translations = [ [x...] for x in full_translations]
#
#   elemtrans = Dict{Permutation, Vector{Int}}()
#   for (ig, dist) in enumerate(full_translations)
#     g = prod(gen^d for (gen, d) in zip(generators, dist))
#     if !haskey(elemtrans, g)
#       elemtrans[g] = [dist...]
#     end
#   end
#   elements = Permutation[]
#   translations = Vector{Int}[]
#   for (e, t) in elemtrans
#     push!(elements, e)
#     push!(translations, t)
#   end
#   idx = sortperm(translations)
#   translations = translations[idx]
#   elements = elements[idx]
# end
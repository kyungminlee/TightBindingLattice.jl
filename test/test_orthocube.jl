using Test
using TightBindingLattice


@testset "OrthoCube" begin

    @testset "failures" begin
        @test_throws DimensionMismatch OrthoCube([1 2 3; 4 5 6])
        @test_throws ArgumentError OrthoCube([1 1; 1 1])
    end

    @testset "orthogonal" begin
        orthocube = OrthoCube([3 0; 0 3])
        @test dimension(orthocube) == 2
        @test isequiv(orthocube, OrthoCube([3 0; 3 3]))
        @test !isequiv(orthocube, OrthoCube([3 0; 1 3]))
        @test !isequiv(orthocube, OrthoCube([6 0; 0 6]))
        @test !isequiv(OrthoCube([6 0; 0 6]), orthocube)

        for i in 0:6, j in 0:6
            @test orthocube.wrap([i, j]) == ([i÷3, j÷3], [i%3, j%3])
        end
        let r = hcat([[i,j] for i in 0:6 for j in 0:6]...),
            R = hcat([[i÷3,j÷3] for i in 0:6 for j in 0:6]...),
            ρ = hcat([[i%3,j%3] for i in 0:6 for j in 0:6]...)
            @test orthocube.wrap(r) == (R, ρ)
        end
    end

    @testset "nonorthogonal" begin
        orthocube = OrthoCube([2 1; 1 2])
        @test orthocube.inverse_shape_matrix == [2//3 -1//3; -1//3 2//3]
        @test dimension(orthocube) == 2
        @test orthocube.wrap([0,0]) == ([0,  0], [0, 0])
        @test orthocube.wrap([1,0]) == ([0, -1], [2, 2])
        @test orthocube.wrap([2,0]) == ([1, -1], [1, 1])
        @test orthocube.wrap([3,0]) == ([2, -1], [0, 0])
    end

    @testset "generator" begin
        ortho = OrthoCube([4 0; 0 3])
        generate_coordinates(ortho, [ 1 4; -1 -3])
        generate_coordinates(ortho, [ 1 0; 0 1])
        @test_throws DimensionMismatch generate_coordinates(ortho, [ 1 0 0; 0 1 0]) # not square
        @test_throws ArgumentError generate_coordinates(ortho, [ 2 0; 0 1]) # unimodular
        @test_throws ArgumentError generate_coordinates(ortho, [ 1 0; 1 1])
        # c2 = generate_coordinates(ortho, [1 0; 0 1])
    end

end

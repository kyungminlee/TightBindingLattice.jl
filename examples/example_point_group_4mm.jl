# # Point group 4mm (C₄ᵥ)

# ## Preamble
using TightBindingLattice
using Formatting: printfmt

function display_matrix(io::IO, matrix::AbstractMatrix; prefix::AbstractString="")
    width = ceil(Int, maximum(length("$item") for item in matrix)/4)*4
    for row in eachrow(matrix)
        for (icol, col) in enumerate(row)
            if icol == 1
                print(io, prefix)
                printfmt(io, "{:>$(width)s}", "$col")
            else
                printfmt(io, " {:>$(width)s}", "$col")
            end
        end
        println(io)
    end
end

# ## Irreps of 4mm
point_symmetry = project(PointSymmetryDatabase.get(13), [1 0 0; 0 1 0])
println("symmetry: ", point_symmetry.hermann_mauguin)
println("order: ", group_order(point_symmetry))
println("irreducible_representations:")
for irrep_index in 1:num_irreps(point_symmetry)
    println("- name: GM($irrep_index)")
    println("  elements:")
    for (ename, mat) in zip(element_names(point_symmetry), irrep(point_symmetry, irrep_index))
        println("  - name: \"$ename\"")
        m = Int.(real.(mat))
        if size(m, 1) == 1
            println("    matrix: $(first(m))")
        else
            println("    matrix: |-")
            display_matrix(stdout, m; prefix="      ")
        end
    end
end
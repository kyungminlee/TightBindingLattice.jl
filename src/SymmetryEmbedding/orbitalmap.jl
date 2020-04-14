export findorbitalmap

function findorbitalmap(unitcell::UnitCell,
                        tsym_op::TranslationOperation{<:Integer})::Vector{Tuple{Int, Vector{Int}}}
    norb = numorbital(unitcell)
    dim = dimension(unitcell)
    return [(i, zeros(Int, dim)) for i in 1:norb]
end


function findorbitalmap(unitcell::UnitCell, tsym::TranslationSymmetry)
    return [findorbitalmap(unitcell, m) for m in elements(tsym)]
end


## Lattice mapping
# function findorbitalmap(unitcell::UnitCell,
#                         psym_matrep::AbstractMatrix{<:Integer})::Vector{Tuple{Int, Vector{Int}}}
#     norb = numorbital(unitcell)
#     map = Tuple{Int, Vector{Int}}[]
#     for (orbname, orbfc) in unitcell.orbitals
#         j, Rj = findorbitalindex(unitcell, psym_matrep * orbfc)
#         j <= 0 && return nothing
#         push!(map, (j, Rj))
#     end
#     return map
# end

function findorbitalmap(unitcell::UnitCell,
                        psym_op::PointOperation{<:Integer})::Vector{Tuple{Int, Vector{Int}}}
    norb = numorbital(unitcell)
    map = Tuple{Int, Vector{Int}}[]
    for (orbname, orbfc) in unitcell.orbitals
        j, Rj = findorbitalindex(unitcell, psym_op.matrix * orbfc)
        j <= 0 && return nothing
        push!(map, (j, Rj))
    end
    return map
end




function findorbitalmap(unitcell::UnitCell, psym::PointSymmetry)
    return [findorbitalmap(unitcell, m) for m in elements(psym)]
end
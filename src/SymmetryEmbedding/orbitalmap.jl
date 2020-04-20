export findorbitalmap


"""
    findorbitalmap(unitcell, translation_operation)
"""
function findorbitalmap(unitcell::UnitCell,
                        tsym_op::TranslationOperation{<:Integer})::Vector{Tuple{Int, Vector{Int}}}
    norb = numorbital(unitcell)
    dim = dimension(unitcell)
    return [(i, zeros(Int, dim)) for i in 1:norb]
    # Zero because in the end, the transformation will be a combination
    # of Bravais lattice transformation, and the result here.
    # All the integer translation will be taken care of by the bravais lattice transformation
end

"""
    findorbitalmap(unitcell, translation_symmetry)
"""
function findorbitalmap(unitcell::UnitCell, tsym::TranslationSymmetry)
    return [findorbitalmap(unitcell, m) for m in elements(tsym)]
end


"""
    findorbitalmap(unitcell, point_operation)
"""
function findorbitalmap(unitcell::UnitCell,
                        psym_op::PointOperation{<:Integer})::Vector{Tuple{Int, Vector{Int}}}
    norb = numorbital(unitcell)
    map = Tuple{Int, Vector{Int}}[]
    for (orbname, orbfc) in unitcell.orbitals
        j, Rj = findorbitalindex(unitcell, psym_op.matrix * orbfc)
        j <= 0 && throw(ArgumentError("orbital map not found with $unitcell and $psym_op"))
        push!(map, (j, Rj))
    end
    return map
end

"""
    findorbitalmap(unitcell, point_symmetry)
"""
function findorbitalmap(unitcell::UnitCell, psym::PointSymmetry)
    return [findorbitalmap(unitcell, m) for m in elements(psym)]
end
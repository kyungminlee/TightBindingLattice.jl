export AbstractSymmetryEmbedding

export TranslationSymmetryEmbedding
export PointSymmetryEmbedding
export SymmorphicSpaceSymmetryEmbedding

export embed
export element, elements

abstract type AbstractSymmetryEmbedding end


struct ProductSymmetry{S1<:AbstractSymmetry, S2<:AbstractSymmetry}
    symmetry1::S1
    symmetry2::S2

    function ProductSymmetry(sym1::S1, sym2::S2) where {S1<:AbstractSymmetry, S2<:AbstractSymmetry}
        new{S1, S2}(sym1, sym2)
    end
end


struct TranslationSymmetryEmbedding<:AbstractSymmetryEmbedding
    lattice::Lattice
    symmetry::TranslationSymmetry
    elements::Vector{SitePermutation}

    function TranslationSymmetryEmbedding(lattice::Lattice, symmetry::TranslationSymmetry)
        if (lattice.hypercube != symmetry.hypercube)
            throw(ArgumentError("lattice and translation symmetry not compatible"))
        end
        elements = [embed(lattice, elem) for elem in symmetry.elements]
        new(lattice, symmetry, elements)
    end
end


elements(symbed::TranslationSymmetryEmbedding) = symbed.elements
element(symbed::TranslationSymmetryEmbedding, g) = symbed.elements[g]


struct PointSymmetryEmbedding<:AbstractSymmetryEmbedding
    lattice::Lattice
    symmetry::PointSymmetry
    elements::Vector{SitePermutation}

    function PointSymmetryEmbedding(lattice::Lattice, symmetry::PointSymmetry)
        if !iscompatible(lattice.hypercube, symmetry)
            throw(ArgumentError("lattice and point symmetry not compatible"))
        end
        elements = [embed(lattice, elem) for elem in symmetry.elements]
        new(lattice, symmetry, elements)
    end
end


elements(symbed::PointSymmetryEmbedding) = symbed.elements
element(symbed::PointSymmetryEmbedding, g) = symbed.elements[g]


struct SymmorphicSpaceSymmetryEmbedding<:AbstractSymmetryEmbedding
    lattice::Lattice
    translation_symmetry::TranslationSymmetry
    point_symmetry::PointSymmetry
    elements::Matrix{SitePermutation}

    function SymmorphicSpaceSymmetryEmbedding(
                lattice::Lattice,
                translation::TranslationSymmetry,
                point::PointSymmetry)
        if !iscompatible(translation, point)
            throw(ArgumentError("translation symmetry and point symmetry not compatible"))
        end
        tels = [embed(lattice, elem) for elem in translation.elements]
        pels = [embed(lattice, elem) for elem in point.elements]
        elements = [pop * top for top in tels, pop in pels]
        @assert size(elements) == (length(tels), length(pels))
        new(lattice, translation, point, elements)
    end
end



for f in [:group_order,
          :group_multiplication_table,
          :element_names,
          :element_name,
          :character_table,
          :irreps,
          :irrep,
          :num_irreps,
          :irrep_dimension]
    eval(quote
        ($f)(symbed::TranslationSymmetryEmbedding, args...) = ($f)(symbed.symmetry, args...)
        ($f)(symbed::PointSymmetryEmbedding, args...) = ($f)(symbed.symmetry, args...)
    end)
end


function embed(lattice::Lattice, tsym::TranslationSymmetry)
    TranslationSymmetryEmbedding(lattice, tsym)
end

function embed(lattice::Lattice, psym::PointSymmetry)
    PointSymmetryEmbedding(lattice, psym)
end

function embed(lattice::Lattice, tsym::TranslationSymmetry, psym::PointSymmetry)
    SymmorphicSpaceSymmetryEmbedding(lattice, tsym, psym)
end

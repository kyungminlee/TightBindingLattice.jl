var documenterSearchIndex = {"docs":
[{"location":"#TightBindingLattice-1","page":"TightBindingLattice","title":"TightBindingLattice","text":"","category":"section"},{"location":"#","page":"TightBindingLattice","title":"TightBindingLattice","text":"Lattice.","category":"page"},{"location":"#","page":"TightBindingLattice","title":"TightBindingLattice","text":"Group has group structure. Examples are FiniteAbelianGroup, GenericGroup","category":"page"},{"location":"#","page":"TightBindingLattice","title":"TightBindingLattice","text":"Multiplication table\norder (period length) of every element","category":"page"},{"location":"#","page":"TightBindingLattice","title":"TightBindingLattice","text":"Symmetry is the \"presentation\" of group.","category":"page"},{"location":"#","page":"TightBindingLattice","title":"TightBindingLattice","text":"Symmetry on the other hand, is a representation of the group structure in some space. Examples are: TranslationSymmetry, PointSymmetry. Members are","category":"page"},{"location":"#","page":"TightBindingLattice","title":"TightBindingLattice","text":"group\ngenerators\nconjugacy_classes\ncharacter_table\nirreps\nelement names","category":"page"},{"location":"#","page":"TightBindingLattice","title":"TightBindingLattice","text":"PointSymmetry has additional info","category":"page"},{"location":"#","page":"TightBindingLattice","title":"TightBindingLattice","text":"matrix_representations (i.e. representation in units of lattice vectors)\nSchoenflies\nHermann Mauguinn","category":"page"},{"location":"#","page":"TightBindingLattice","title":"TightBindingLattice","text":"Modules = [TightBindingLattice]","category":"page"},{"location":"#TightBindingLattice.CarteCoord","page":"TightBindingLattice","title":"TightBindingLattice.CarteCoord","text":"CarteCoord\n\nCartesian coordinates. Vector{Float64}.\n\n\n\n\n\n","category":"type"},{"location":"#TightBindingLattice.FractCoord","page":"TightBindingLattice","title":"TightBindingLattice.FractCoord","text":"FractCoord\n\nFractional coordinates.\n\nMembers\n\nwhole ::Vector{Int}: Integer part of fractional coordinates\nfraction ::Vector{Float64}: [0,1) part of fractional coordinates\n\n\n\n\n\n","category":"type"},{"location":"#TightBindingLattice.Permutation","page":"TightBindingLattice","title":"TightBindingLattice.Permutation","text":"    Permutation(perms; max_order=2048)\n\nCreate a permutation of integers from 1 to n. perms should be a permutation of 1:n.\n\nArguments\n\nperms: an integer vector containing a permutation of integers from 1 to n\nmax_order: maximum order\n\nNote\n\nThe convention for the permutation is that map[i] gets mapped to i. In other words, map tells you where each element is from.\n\n\n\n\n\n","category":"type"},{"location":"#TightBindingLattice.UnitCell","page":"TightBindingLattice","title":"TightBindingLattice.UnitCell","text":"UnitCell{O}\n\nParameters\n\nO: type of \"orbital\". Any type can be used, but we recommend using String or tuple of String and Int      for compatibility with JSON.\n\nMembers\n\nlatticevectors ::Array{Float64, 2}: Lattice vectors\nreducedreciprocallatticevectors ::Array{Float64, 2}: Reduced reciprocal lattice vectors (transpose of inverse of latticevectors)\nreciprocallatticevectors ::Array{Float64, 2}: Reciprocal lattice vectors. 2π * reducedreciprocallatticevectors\norbitals ::Vector{Tuple{T, FractCoord}}: List of orbitals within unit cell\norbitalindices ::Dict{T, Int}: Indices of orbitals\n\n\n\n\n\n","category":"type"},{"location":"#TightBindingLattice.addorbital!-Union{Tuple{O}, Tuple{UnitCell{O},O,FractCoord}} where O","page":"TightBindingLattice","title":"TightBindingLattice.addorbital!","text":"addorbital!\n\nAdd an orbital to the unit cell.\n\nArguments\n\nuc ::UnitCell{T}\norbitalname ::{T}\norbitalcoord ::FractCoord\n\n\n\n\n\n","category":"method"},{"location":"#TightBindingLattice.carte2fract-Tuple{AbstractArray{#s27,2} where #s27<:AbstractFloat,Array{Float64,1}}","page":"TightBindingLattice","title":"TightBindingLattice.carte2fract","text":"carte2fract\n\nArguments\n\nlatticevectors ::AbstractArray{<:AbstractFloat, 2}: square matrix whose columns are lattice vectors.\ncc ::CarteCoord: cartesian coordinates\ntol ::Real=sqrt(eps(Float64)): tolerance\n\n\n\n\n\n","category":"method"},{"location":"#TightBindingLattice.carte2fract-Tuple{UnitCell,Array{Float64,1}}","page":"TightBindingLattice","title":"TightBindingLattice.carte2fract","text":"carte2fract\n\nArguments\n\nlatticevectors ::Array{Float64, 2}\ncc ::CarteCoord\n\n\n\n\n\n","category":"method"},{"location":"#TightBindingLattice.dimension-Tuple{FractCoord}","page":"TightBindingLattice","title":"TightBindingLattice.dimension","text":"dimension\n\nDimension of the fractional coordinates\n\nArguments\n\nfc ::FractCoord: Fractional coordinates.\n\n\n\n\n\n","category":"method"},{"location":"#TightBindingLattice.dimension-Tuple{UnitCell}","page":"TightBindingLattice","title":"TightBindingLattice.dimension","text":"dimension\n\nSpatial dimension of the unit cell.\n\n\n\n\n\n","category":"method"},{"location":"#TightBindingLattice.findorbitalindex-Tuple{UnitCell,FractCoord}","page":"TightBindingLattice","title":"TightBindingLattice.findorbitalindex","text":"findorbitalindex\n\nReturns (orbitalindex, unitcellvector), or (-1, []) if not found.\n\n\n\n\n\n","category":"method"},{"location":"#TightBindingLattice.fract2carte-Tuple{AbstractArray{#s36,2} where #s36<:AbstractFloat,FractCoord}","page":"TightBindingLattice","title":"TightBindingLattice.fract2carte","text":"fract2carte\n\nArguments\n\nlatticevectors ::AbstractArray{<:AbstractFloat, 2}: square matrix whose columns are lattice vectors.\nfc ::FractCoord: fractional coordinates\n\n\n\n\n\n","category":"method"},{"location":"#TightBindingLattice.fract2carte-Tuple{UnitCell,FractCoord}","page":"TightBindingLattice","title":"TightBindingLattice.fract2carte","text":"fract2carte\n\nArguments\n\nlatticevectors ::Array{Float64, 2}\nfc ::FractCoord\n\n\n\n\n\n","category":"method"},{"location":"#TightBindingLattice.generate_subgroup-Tuple{FiniteGroup,Integer}","page":"TightBindingLattice","title":"TightBindingLattice.generate_subgroup","text":"generate_subgroup(group, idx)\n\nsubgroup generated by generators. ⟨ {g} ⟩\n\n\n\n\n\n","category":"method"},{"location":"#TightBindingLattice.generate_subgroup-Union{Tuple{G}, Tuple{FiniteGroup,G}} where G<:(Union{#s34, #s33} where #s33<:(AbstractArray{#s31,1} where #s31<:Integer) where #s34<:(AbstractSet{#s32} where #s32<:Integer))","page":"TightBindingLattice","title":"TightBindingLattice.generate_subgroup","text":"generate_subgroup(group, generators)\n\nsubgroup generated by generators. ⟨ S ⟩\n\n\n\n\n\n","category":"method"},{"location":"#TightBindingLattice.getorbital-Tuple{UnitCell,Integer}","page":"TightBindingLattice","title":"TightBindingLattice.getorbital","text":"getorbital\n\nArguments\n\nuc ::UnitCell{T}\nindex ::Integer\n\nReturn\n\n(orbitalname, fractcoord)\n\n\n\n\n\n","category":"method"},{"location":"#TightBindingLattice.getorbital-Union{Tuple{O}, Tuple{UnitCell{O},O}} where O","page":"TightBindingLattice","title":"TightBindingLattice.getorbital","text":"getorbital\n\nGet the orbital (its orbital name and its fractional coordinates) with the given name.\n\nArguments\n\nuc ::UnitCell{O}\nname ::O\n\nReturn\n\n(orbitalname, fractcoord)\n\n\n\n\n\n","category":"method"},{"location":"#TightBindingLattice.getorbitalcoord-Tuple{UnitCell,Integer}","page":"TightBindingLattice","title":"TightBindingLattice.getorbitalcoord","text":"getorbitalcoord\n\nArguments\n\nuc ::UnitCell\nidx ::Integer\n\nReturn\n\nfractcoord\n\n\n\n\n\n","category":"method"},{"location":"#TightBindingLattice.getorbitalcoord-Union{Tuple{O}, Tuple{UnitCell{O},O}} where O","page":"TightBindingLattice","title":"TightBindingLattice.getorbitalcoord","text":"getorbitalcoord\n\nGet the fractional coordinates of the orbital with the given name.\n\nArguments\n\nuc ::UnitCell{O}\nname ::O\n\nReturn\n\nfractcoord\n\n\n\n\n\n","category":"method"},{"location":"#TightBindingLattice.getorbitalindex-Union{Tuple{O}, Tuple{UnitCell{O},O}} where O","page":"TightBindingLattice","title":"TightBindingLattice.getorbitalindex","text":"getorbitalindex\n\nGet index of the given orbital.\n\nArguments\n\nuc ::UnitCell{O}\nname ::O\n\n\n\n\n\n","category":"method"},{"location":"#TightBindingLattice.getorbitalindexcoord-Union{Tuple{O}, Tuple{UnitCell{O},O}} where O","page":"TightBindingLattice","title":"TightBindingLattice.getorbitalindexcoord","text":"getorbitalindexcoord\n\nArguments\n\nuc ::UnitCell{T}\nname ::T\n\nReturn\n\n(index, fractcoord)\n\n\n\n\n\n","category":"method"},{"location":"#TightBindingLattice.getorbitalname-Tuple{UnitCell,Integer}","page":"TightBindingLattice","title":"TightBindingLattice.getorbitalname","text":"getorbitalname\n\nArguments\n\nuc ::UnitCell\nindex ::Integer\n\nReturn\n\norbitalname\n\n\n\n\n\n","category":"method"},{"location":"#TightBindingLattice.group_inverse-Tuple{FiniteGroup,Integer}","page":"TightBindingLattice","title":"TightBindingLattice.group_inverse","text":"group_inverse(group, g)\n\nGet inverse of element g\n\n\n\n\n\n","category":"method"},{"location":"#TightBindingLattice.group_inverse-Tuple{FiniteGroup}","page":"TightBindingLattice","title":"TightBindingLattice.group_inverse","text":"group_inverse(group)\n\nGet a function which gives inverse\n\n\n\n\n\n","category":"method"},{"location":"#TightBindingLattice.group_isomorphism-Tuple{FiniteGroup,FiniteGroup}","page":"TightBindingLattice","title":"TightBindingLattice.group_isomorphism","text":"group_isomorphism(group1, group2)\n\nFind the isomorphism ϕ: G₁ → G₂. Return nothing if not isomorphic.\n\n\n\n\n\n","category":"method"},{"location":"#TightBindingLattice.group_multiplication_table-Union{Tuple{AbstractArray{ElementType,1}}, Tuple{ElementType}, Tuple{AbstractArray{ElementType,1},Function}} where ElementType","page":"TightBindingLattice","title":"TightBindingLattice.group_multiplication_table","text":"group_multiplication_table(elements, product=(*))\n\nGenerate a multiplication table from elements with product.\n\n\n\n\n\n","category":"method"},{"location":"#TightBindingLattice.group_order-Tuple{FiniteGroup,Any}","page":"TightBindingLattice","title":"TightBindingLattice.group_order","text":"group_order(group, g)\n\nOrder of group element (i.e. period length)\n\n\n\n\n\n","category":"method"},{"location":"#TightBindingLattice.group_order-Tuple{FiniteGroup}","page":"TightBindingLattice","title":"TightBindingLattice.group_order","text":"group_order(group)\n\nOrder of group (i.e. number of elements)\n\n\n\n\n\n","category":"method"},{"location":"#TightBindingLattice.group_product-Tuple{FiniteGroup,Integer,Integer}","page":"TightBindingLattice","title":"TightBindingLattice.group_product","text":"group_product(group, lhs, rhs)\n\n\n\n\n\n","category":"method"},{"location":"#TightBindingLattice.hasorbital-Union{Tuple{O}, Tuple{UnitCell{O},O}} where O","page":"TightBindingLattice","title":"TightBindingLattice.hasorbital","text":"hasorbital{T}\n\nTest whether the unit cell contains the orbital of given name.\n\nArguments\n\nuc ::UnitCell{O}\nname ::O\n\n\n\n\n\n","category":"method"},{"location":"#TightBindingLattice.issubgroup-Tuple{FiniteGroup,AbstractSet{#s89} where #s89<:Integer}","page":"TightBindingLattice","title":"TightBindingLattice.issubgroup","text":"issubgroup(mtab, subset)\n\n\n\n\n\n","category":"method"},{"location":"#TightBindingLattice.linpath-Tuple{AbstractArray{#s31,1} where #s31<:(AbstractArray{#s29,1} where #s29<:Number)}","page":"TightBindingLattice","title":"TightBindingLattice.linpath","text":"momentumpath\n\nGenerate a list of momenta\n\nArguments\n\nanchorpoints\n(Optional) nseg - number of points in each segment\n\n\n\n\n\n","category":"method"},{"location":"#TightBindingLattice.little_group-Tuple{TranslationSymmetry,PointSymmetry,AbstractArray{#s35,1} where #s35<:Integer}","page":"TightBindingLattice","title":"TightBindingLattice.little_group","text":"Generate a little group with given elements. The elements of the little group, which may be sparse, are compressed into consecutive integers.\n\n\n\n\n\n","category":"method"},{"location":"#TightBindingLattice.little_symmetry_iso-Tuple{TranslationSymmetry,Integer,PointSymmetry}","page":"TightBindingLattice","title":"TightBindingLattice.little_symmetry_iso","text":"little_symmetry_iso(tsym, tsym_irrep_index, psym)\n\nFind little symmetry using group isomorphism\n\n\n\n\n\n","category":"method"},{"location":"#TightBindingLattice.make_unitcell-Tuple{AbstractArray{#s35,2} where #s35<:Real}","page":"TightBindingLattice","title":"TightBindingLattice.make_unitcell","text":"UnitCell\n\nConstruct an n-dimensional lattice.\n\nArguments\n\nlatticevectors ::AbstractArray{<:AbstractFloat, 2}: Lattice vectors\nOrbitalType::DataType\n\nOptional Arguments\n\ntol=sqrt(eps(Float64)): Epsilon\n\n\n\n\n\n","category":"method"},{"location":"#TightBindingLattice.make_unitcell-Tuple{Real}","page":"TightBindingLattice","title":"TightBindingLattice.make_unitcell","text":"UnitCell\n\nConstruct a one-dimensional lattice.\n\nArguments\n\nlatticeconstant ::Float64: Lattice constant\nOrbitalType: List of orbitals\n\nOptional Arguments\n\ntol=sqrt(eps(Float64)): Tolerance\n\n\n\n\n\n","category":"method"},{"location":"#TightBindingLattice.minimal_generating_set-Tuple{FiniteGroup}","page":"TightBindingLattice","title":"TightBindingLattice.minimal_generating_set","text":"minimal_generating_set\n\n\n\n\n\n","category":"method"},{"location":"#TightBindingLattice.momentumgrid-Tuple{UnitCell,AbstractArray{#s89,1} where #s89<:Integer}","page":"TightBindingLattice","title":"TightBindingLattice.momentumgrid","text":"momentumgrid\n\nGenerate an n-dimensional grid of momenta of given shape\n\n\n\n\n\n","category":"method"},{"location":"#TightBindingLattice.momentumpath-Tuple{UnitCell,AbstractArray{#s39,1} where #s39<:(AbstractArray{#s38,1} where #s38<:Number)}","page":"TightBindingLattice","title":"TightBindingLattice.momentumpath","text":"momentumpath\n\nThe anchorpoints are given in units of the reciprocal lattice vectors.\n\n\n\n\n\n","category":"method"},{"location":"#TightBindingLattice.numorbital-Tuple{UnitCell}","page":"TightBindingLattice","title":"TightBindingLattice.numorbital","text":"numorbital\n\nNumber of orbitals of the unit cell.\n\nArguments\n\nuc ::UnitCell\n\n\n\n\n\n","category":"method"},{"location":"#TightBindingLattice.orthogonalize-Tuple{HypercubicLattice}","page":"TightBindingLattice","title":"TightBindingLattice.orthogonalize","text":"    orthogonalize\n\nFind orthogonal generators of the hypercube, and reorder the coordinates accordingly\n\n\n\n\n\n","category":"method"},{"location":"#TightBindingLattice.whichunitcell-Union{Tuple{O}, Tuple{UnitCell{O},O,Array{Float64,1}}} where O","page":"TightBindingLattice","title":"TightBindingLattice.whichunitcell","text":"whichunitcell\n\nReturn\n\nR ::Vector{Int}: which unit cell the specificied orbital/cartesian coordinates belongs to.\n\n\n\n\n\n","category":"method"},{"location":"#TightBindingLattice.whichunitcell-Union{Tuple{O}, Tuple{UnitCell{O},O,FractCoord}} where O","page":"TightBindingLattice","title":"TightBindingLattice.whichunitcell","text":"whichunitcell\n\nReturn\n\nR ::Vector{Int}: which unit cell the specificied orbital/cartesian coordinates belongs to.\n\n\n\n\n\n","category":"method"},{"location":"#Base.:*-Tuple{Permutation,Permutation}","page":"TightBindingLattice","title":"Base.:*","text":"    *(p1 ::Permutation, p2 ::Permutation)\n\nMultiply the two permutation. NOT THIS: (Return [p2.map[x] for x in p1.map].) BUT THIS: Return [p1.map[x] for x in p2.map].\n\nExamples\n\njulia> using TightBindingLattice\n\njulia> Permutation([2,1,3]) * Permutation([1,3,2])\nPermutation([2, 3, 1], 3)\n\njulia> Permutation([1,3,2]) * Permutation([2,1,3])\nPermutation([3, 1, 2], 3)\n\n\n\n\n\n","category":"method"},{"location":"#Base.:^-Tuple{Permutation,Integer}","page":"TightBindingLattice","title":"Base.:^","text":"^(perm ::Permutation, pow ::Integer)\n\nExponentiate the permutation.\n\nExamples\n\njulia> using TightBindingLattice\n\njulia> Permutation([2,3,4,1])^2\nPermutation([3, 4, 1, 2], 2)\n\n\n\n\n\n","category":"method"},{"location":"#TightBindingLattice.conjugacy_class-Tuple{FiniteGroup,Integer}","page":"TightBindingLattice","title":"TightBindingLattice.conjugacy_class","text":"conjugacy_class(group, i)\n\nConjugacy class of the element i.\n\n\n\n\n\n","category":"method"}]
}

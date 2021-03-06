# Symmetry Analysis


## Group

**Group** contains the group structure of a symmetry
- multiplication table
- order (period length) of every element
Currently, the only type which implements a group is [`FiniteGroup`](@ref).


## Space Symmetry

**Symmetry** on the other hand, is a representation of the group structure in some space.
Examples are: [`TranslationSymmetry`](@ref), [`PointSymmetry`](@ref). Fields are
- group
- generators
- conjugacy classes
- character table
- irreps
- element names

### Translation Symmetry

[`TranslationSymmetry`](@ref)

### Point Symmetry

[`PointSymmetry`](@ref) has additional info
- matrix_representations (i.e. representation in units of lattice vectors)
- Schoenflies
- Hermann-Mauguin

### Symmorphic Space Symmetry



## Symmetry Embedding

An "embedding" of a symmetry onto a lattice, is a symmetry structure whose
elements are permutations of sites represented by [`SitePermutation`](@ref).


### Symmetry Embedding of Symmorphic Symmetry

Site mapping

```
     T ⋊ P →  E(L,P)

     ↓     ↘    ↓

  E(L,T)   →  E(L, T ⋊ P)
```



## Compatibility between symmetries, symmetry-embeddings, and their irrep components

In case of (symmorphic) space symmetry, we want to make sure that the translation symmetry and the point symmetry are "compatible".

The compatibility condition is the following


### 1. Between lattice and translation symmetry

Lattice is built on (1) definition of unitcell, and (2) Bravais lattice.
Since the second part, the Bravais lattice (with periodic boundary condition),
encodes directly the information of the translation symmetry,
a [`Lattice`](@ref) and a [`TranslationSymmetry`](@ref) is compatible if they
*share the same Bravais lattice*. No further requirement is needed.


### 2. Between lattice and point symmetry

In order for a point symmetry to be a good symmetry of the lattice,
we need the Bravais lattice to be invariant under the point symmetry at least.
In an infinite lattice, this is always the case, and no requires no checks.
For finite size lattice, however, the situation is different:
Since the finite size lattice with periodic boundary condition can be
understood as an infinite lattice modulo supercell,
the Bravais lattice of the *supercell* also needs to be invariant under
all operations of the point symmetry. The requirement therefore is that
the column vectors of the shape matrix after point operation remain
integer multiples of themselves.


### 3. Between translation symmetry and point symmetry.

Same as 2.


### 4. Between lattice and translation symmetry embedding.

Translation symmetry embedding is 

|  a  |  TS    |  PS    |  L     |  TSE   |  PSE   |
| :-: | :---------------: | :----: | :----: | :----: | :----: |
| TS  | same matrix | shape matrix invariant under point operation     | same shape matrix  |       |       |
| PS  |        |      |      |       |       |
| L   |        |      |      |       |       |
| TSE |        |      |      |       |       |
| PSE |        |      |      |       |       |



## Symmorphic Symmetry
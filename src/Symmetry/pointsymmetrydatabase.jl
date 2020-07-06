
module PointSymmetryDatabase

using YAML
using JLD2
using FileIO
using Serialization

import ..TightBindingLattice: PointSymmetry, read_point_symmetry, simplify_name

loaded = false

NUM_POINT_SYMMETRIES_2D = 11
POINT_SYMMETRY_DATABASE_2D = Vector{PointSymmetry}(undef, NUM_POINT_SYMMETRIES_2D)
POINT_SYMMETRY_LOOKUP_2D = Dict{Vector{String}, Int}()

NUM_POINT_SYMMETRIES_3D = 32
POINT_SYMMETRY_DATABASE_3D = Vector{PointSymmetry}(undef, NUM_POINT_SYMMETRIES_3D)
POINT_SYMMETRY_LOOKUP_3D = Dict{Vector{String}, Int}()


function load()
    let data_directory = abspath(joinpath(@__DIR__, "..", "..", "data", "PointGroup2D")),
        filepath = joinpath(data_directory, "cache.data")
        if isfile(filepath)
            db = deserialize(filepath)
            global POINT_SYMMETRY_DATABASE_2D = db.database
            global POINT_SYMMETRY_LOOKUP_2D = db.lookup
        else
            for group_index in 1:NUM_POINT_SYMMETRIES_2D
                psym = load_group_2d(group_index)
                global POINT_SYMMETRY_DATABASE_2D[group_index] = psym
                global POINT_SYMMETRY_LOOKUP_2D[sort(simplify_name.(psym.element_names))] = group_index
            end
            serialize(filepath,
                      (database=POINT_SYMMETRY_DATABASE_2D,
                       lookup=POINT_SYMMETRY_LOOKUP_2D))
        end
    end
    let data_directory = abspath(joinpath(@__DIR__, "..", "..", "data", "PointGroup3D")),
        filepath = joinpath(data_directory, "cache.data")
        if isfile(filepath)
            db = deserialize(filepath)
            global POINT_SYMMETRY_DATABASE_3D = db.database
            global POINT_SYMMETRY_LOOKUP_3D = db.lookup
        else
            for group_index in 1:NUM_POINT_SYMMETRIES_3D
                psym = load_group_3d(group_index)
                global POINT_SYMMETRY_DATABASE_3D[group_index] = psym
                global POINT_SYMMETRY_LOOKUP_3D[sort(simplify_name.(psym.element_names))] = group_index
            end
            serialize(filepath,
                      (database=POINT_SYMMETRY_DATABASE_3D,
                       lookup=POINT_SYMMETRY_LOOKUP_3D))
        end
    end
    global loaded = true
end


function __init__()
    global loaded
    if !loaded
        load()
    end
end

function load_group_2d(group_index::Integer)
    data_directory = abspath(joinpath(@__DIR__, "..", "..", "data", "PointGroup2D"))
    file_path = joinpath(data_directory, "PointGroup2D-$group_index.yaml")
    data_yaml = YAML.load_file(file_path)
    point_symmetry = read_point_symmetry(data_yaml)
    return point_symmetry
end

function load_group_3d(group_index::Integer)
    data_directory = abspath(joinpath(@__DIR__, "..", "..", "data", "PointGroup3D"))
    file_path = joinpath(data_directory, "PointGroup3D-$group_index.yaml")
    data_yaml = YAML.load_file(file_path)
    point_symmetry = read_point_symmetry(data_yaml)
    return point_symmetry
end

# 3D by default
get(args...) = get3d(args...)
find(args...) = find3d(args...)

function get2d(group_index::Integer)
    (group_index < 1 || group_index > NUM_POINT_SYMMETRIES_2D) && throw(ArgumentError("Point group 2D #$group_index not found"))
    #if !isassigned(POINT_SYMMETRY_DATABASE_2D, group_index)
    #    POINT_SYMMETRY_DATABASE_2D[group_index] = load_group_2d(group_index)
    #end
    return POINT_SYMMETRY_DATABASE_2D[group_index]
end

function get3d(group_index::Integer)
    (group_index < 1 || group_index > NUM_POINT_SYMMETRIES_3D) && throw(ArgumentError("Point group 3D #$group_index not found"))
    # if !isassigned(POINT_SYMMETRY_DATABASE_3D, group_index)
    #     POINT_SYMMETRY_DATABASE_3D[group_index] = load_group_3d(group_index)
    # end
    return POINT_SYMMETRY_DATABASE_3D[group_index]
end

function find2d(group_name::AbstractString)
    for i in 1:NUM_POINT_SYMMETRIES_2D
        psym = get2d(i)
        if group_name == psym.hermann_mauguin
            return psym
        end
    end
    return nothing
end

function find3d(group_name::AbstractString)
    for i in 1:NUM_POINT_SYMMETRIES_3D
        psym = get3d(i)
        if group_name == psym.hermann_mauguin
            return psym
        end
    end
    return nothing
end

function find2d(element_names::AbstractVector{<:AbstractString})
    simple_names = sort(simplify_name.(element_names))
    return POINT_SYMMETRY_LOOKUP_2D[simple_names]
end

function find3d(element_names::AbstractVector{<:AbstractString})
    simple_names = sort(simplify_name.(element_names))
    return POINT_SYMMETRY_LOOKUP_3D[simple_names]
end

end # module PointSymmetryDatabase

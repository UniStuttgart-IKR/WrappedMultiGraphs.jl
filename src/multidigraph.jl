mutable struct MultiDiGraph{T <: Integer} <: AbstractMultiGraph{T}
    graph::SimpleDiGraph{T}

    MultiDiGraph{T}(args...) where T<:Integer = new{T}(SimpleDiGraph{T}(args...))
    MultiDiGraph{T}(sg::SimpleDiGraph{T}) where T<:Integer = new{T}(sg)
end

function MultiDiGraph(args...) 
    sg = SimpleDiGraph(args...)
    MultiDiGraph{eltype(sg)}(sg)
end

is_directed(::Type{<:MultiDiGraph}) = true
is_directed(mg::MultiDiGraph) = true
#badj(g::MultiDiGraph, args...) = badj(graph(g), args...)


function add_edge!(mg::MultiDiGraph{T}, e::SimpleDiGraphEdge{T}) where T
    g = graph(mg)
    s, d = T.(Tuple(e))
    verts = vertices(g)
    (s in verts && d in verts) || return false  # edge out of bounds
    @inbounds list = g.fadjlist[s]
    index = searchsortedfirst(list, d)
    #    don't check about double edges
#    @inbounds (index <= length(list) && list[index] == d) && return false  # edge already in graph
    insert!(list, index, d)

    g.ne += 1

    @inbounds list = g.badjlist[d]
    index = searchsortedfirst(list, s)
    insert!(list, index, s)
    return true  # edge successfully added
end


"""
$(TYPEDEF)
$(TYPEDFIELDS)
"""
struct MultiGraph{T <: Integer} <: AbstractMultiGraph{T}
    "The wrapped graph"
    graph::SimpleGraph{T}
    MultiGraph{T}(args...) where T<:Integer = new{T}(SimpleGraph{T}(args...))
    MultiGraph{T}(sg::SimpleGraph{T}) where T<:Integer = new{T}(sg)
end

function MultiGraph(args...) 
    sg = SimpleGraph(args...)
    MultiGraph{eltype(sg)}(sg)
end

is_directed(::Type{<:MultiGraph}) = false
is_directed(mg::MultiGraph) = false

function add_edge!(mg::MultiGraph{T}, e::SimpleGraphEdge{T}) where T
    g = getgraph(mg)
    s, d = T.(Tuple(e))
    verts = vertices(g)
    (s in verts && d in verts) || return false  # edge out of bounds
    @inbounds list = g.fadjlist[s]
    index = searchsortedfirst(list, d)
    #    don't check about double edges
    #    @inbounds (index <= length(list) && list[index] == d) && return false  # edge already in graph
    insert!(list, index, d)

    g.ne += 1
    s == d && return true  # selfloop

    @inbounds list = g.fadjlist[d]
    index = searchsortedfirst(list, s)
    insert!(list, index, s)
    return true  # edge successfully added
end

nonmultigraph(mg::MultiGraph{T}) where T<:Integer = SimpleGraph{T}(length(unique(edges(mg))), unique.(Graphs.SimpleGraphs.fadj(mg)))
toundirected(mg::MultiGraph) = mg
"""
$(TYPEDSIGNATURES)

Convert to a directed graph
"""
todirected(mg::MultiGraph) = MultiDiGraph(SimpleDiGraph(getgraph(mg)))

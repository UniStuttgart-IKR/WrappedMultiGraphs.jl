"""
$(TYPEDEF)
$(TYPEDFIELDS)
"""
mutable struct MultiDiGraph{T <: Integer} <: AbstractMultiGraph{T}
    "The wrapped graph"
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
badj(g::MultiDiGraph, args...) = badj(getgraph(g), args...)


function add_edge!(mg::MultiDiGraph{T}, e::SimpleDiGraphEdge{T}) where T
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

    @inbounds list = g.badjlist[d]
    index = searchsortedfirst(list, s)
    insert!(list, index, s)
    return true  # edge successfully added
end

nonmultigraph(mg::MultiDiGraph{T}) where T<:Integer = SimpleDiGraph{T}(length(unique(edges(mg))), unique.(Graphs.SimpleGraphs.fadj(mg)), unique.(Graphs.SimpleGraphs.badj(mg)))
todirected(mg::MultiDiGraph) = mg
"""
$(TYPEDSIGNATURES)

Convert to an undirected graph
"""
function toundirected(mg::MultiDiGraph)
    dedg = Dict(e => 0 for ed in edges(mg) for e in [ed, reverse(ed)])
    dunedg = Dict(e => 0 for e in undirectededges(mg))
    for e in edges(mg)
        if dedg[e] >= dedg[reverse(e)]
            dunedg[undirectededge(e)] += 1
        end
        dedg[e] += 1
    end
    mug = MultiGraph(SimpleGraph(nv(mg)))
    for (k,v) in dunedg
        for _ in 1:v
            add_edge!(mug, k)
        end
    end
    mug
end

undirectededges(g::AbstractGraph) = undirectededge.(edges(g))
undirectededge(e::E) where E<:AbstractEdge = src(e) > dst(e) ? reverse(e) : e

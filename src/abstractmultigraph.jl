abstract type AbstractMultiGraph{T<:Integer} <: AbstractSimpleGraph{T} end

eltype(::AbstractMultiGraph{T}) where T = T

function show(io::IO, ::MIME"text/plain", g::AbstractMultiGraph{T}) where T
    dir = is_directed(g) ? "directed" : "undirected"
    print(io, "{$(nv(g)), $(ne(g))} $dir multi $T graph")
end

"""
$(TYPEDSIGNATURES)

Get the wrapped graph
"""
getgraph(mg::AbstractMultiGraph) = getfield(mg, :graph)
Base.getproperty(mg::AbstractMultiGraph, f::Symbol) = Base.getproperty(getgraph(mg), f)

# forward all functions
edgetype(mg::AbstractMultiGraph) = edgetype(getgraph(mg))
#copy(g::AbstractMultiGraph) =  copy(graph(g))
##==(g::AbstractMultiGraph, h::AbstractMultiGraph) = graph(g) == graph(h)

has_edge(mg::AbstractMultiGraph, e::Edge) = has_edge(getgraph(mg), e)
rem_edge!(mg::AbstractMultiGraph, e::Edge) = rem_edge!(getgraph(mg), e)
add_vertex!(mg::AbstractMultiGraph) = add_vertex!(getgraph(mg))
rem_vertex!(mg::AbstractMultiGraph, u::Integer) = rem_vertex!(getgraph(mg), u)
rem_vertices!(mg::AbstractMultiGraph, args...) = rem_vertices!(getgraph(mg), args...)

inneighbors(mg::AbstractMultiGraph, u::Integer) = unique(inneighbors(getgraph(mg), u))
outneighbors(mg::AbstractMultiGraph, u::Integer) = unique(outneighbors(getgraph(mg), u))
neighbors(mg::AbstractMultiGraph, u::Integer) = unique(neighbors(getgraph(mg), u))
all_neighbors(mg::AbstractMultiGraph, u::Integer) = unique(all_neighbors(getgraph(mg), u))

adjacency_matrix(mg::AbstractMultiGraph) = adjacency_matrix(nonmultigraph(mg))
nonmultigraph(mg::AbstractMultiGraph) = error("Method is not implemented")

# extended functionality
#count_edges(mg::AbstractMultiGraph, e::AbstractEdge) = count(==(e), edges(mg))
#count_edges(mg::AbstractMultiGraph, s::T, d::T) where T<:Integer = count_edges(mg, Edge(s,d))

has_edge(mg::AbstractMultiGraph, e::AbstractEdge, c::Integer) = count(==(e), edges(mg)) >= c
has_edge(mg::AbstractMultiGraph{T}, s::T, d::T, c::T) where T<:Integer = has_edge(mg, Edge(s,d), c)

add_edge!(mg::AbstractMultiGraph, e::AbstractEdge, c::Integer) = foreach(1:c) do _; add_edge!(mg, e); end 
add_edge!(mg::AbstractMultiGraph, s::T, d::T, c::T) where T<:Integer = add_edge!(mg, Edge(s,d), c)

rem_edge!(mg::AbstractMultiGraph, e::AbstractEdge, c::Integer) = foreach(1:c) do _; rem_edge!(mg, e); end 
rem_edge!(mg::AbstractMultiGraph, s::T, d::T, c::T) where T<:Integer = rem_edge!(mg, Edge(s,d), c)


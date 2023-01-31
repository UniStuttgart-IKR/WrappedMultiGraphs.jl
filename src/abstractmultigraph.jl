abstract type AbstractMultiGraph{T<:Integer} <: AbstractSimpleGraph{T} end

eltype(::AbstractMultiGraph{T}) where T = T

function show(io::IO, ::MIME"text/plain", g::AbstractMultiGraph{T}) where T
    dir = is_directed(g) ? "directed" : "undirected"
    print(io, "{$(nv(g)), $(ne(g))} $dir multi $T graph")
end

graph(mg::AbstractMultiGraph) = getfield(mg, :graph)
Base.getproperty(mg::AbstractMultiGraph, f::Symbol) = Base.getproperty(graph(mg), f)

# forward all functions
edgetype(mg::AbstractMultiGraph) = edgetype(graph(mg))
#copy(g::AbstractMultiGraph) =  copy(graph(g))
##==(g::AbstractMultiGraph, h::AbstractMultiGraph) = graph(g) == graph(h)

has_edge(mg::AbstractMultiGraph, e::Edge) = has_edge(graph(mg), e)
rem_edge!(mg::AbstractMultiGraph, e::Edge) = rem_edge!(graph(mg), e)
add_vertex!(mg::AbstractMultiGraph) = add_vertex!(graph(mg))
rem_vertex!(mg::AbstractMultiGraph, u::Integer) = rem_vertex!(graph(mg), u)
rem_vertices!(mg::AbstractMultiGraph, args...) = rem_vertices!(graph(mg), args...)

inneighbors(mg::AbstractMultiGraph, u::Integer) = unique(inneighbors(graph(mg), u))
outneighbors(mg::AbstractMultiGraph, u::Integer) = unique(outneighbors(graph(mg), u))
neighbors(mg::AbstractMultiGraph, u::Integer) = unique(neighbors(graph(mg), u))
all_neighbors(mg::AbstractMultiGraph, u::Integer) = unique(all_neighbors(graph(mg), u))

# extended functionality
count_edges(mg::AbstractMultiGraph, e::AbstractEdge) = count(==(e), edges(mg))
count_edges(mg::AbstractMultiGraph, s::T, d::T) where T<:Integer = count_edges(mg, Edge(s,d))

has_edge(mg::AbstractMultiGraph, e::AbstractEdge, c::Integer) = count(==(e), edges(mg)) >= c
has_edge(mg::AbstractMultiGraph{T}, s::T, d::T, c::T) where T<:Integer = has_edge(mg, Edge(s,d), c)

add_edge!(mg::AbstractMultiGraph, e::AbstractEdge, c::Integer) = foreach(1:c) do _; add_edge!(mg, e); end 
add_edge!(mg::AbstractMultiGraph, s::T, d::T, c::T) where T<:Integer = add_edge!(mg, Edge(s,d), c)

rem_edge!(mg::AbstractMultiGraph, e::AbstractEdge, c::Integer) = foreach(1:c) do _; rem_edge!(mg, e); end 
rem_edge!(mg::AbstractMultiGraph, s::T, d::T, c::T) where T<:Integer = rem_edge!(mg, Edge(s,d), c)

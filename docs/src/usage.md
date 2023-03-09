# Usage

Start by using all the the needed packages for this walkthrough tutorial and create a `MultiGraph`.
```jldoctest walkthrough 
julia> using MultiGraphs, Graphs

julia> mg = MultiGraph(complete_graph(3))
{3, 3} undirected multi Int64 graph
```

Now go on and add some extra edges!

```jldoctest walkthrough 
julia> add_edge!(mg, 1, 2)
true

julia> add_edge!(mg, 1, 3)
true

julia> mg
{3, 5} undirected multi Int64 graph

julia> edges(mg)
SimpleEdgeIter 5

julia> edges(mg) |> collect
5-element Vector{Any}:
 Edge 1 => 2
 Edge 1 => 2
 Edge 1 => 3
 Edge 1 => 3
 Edge 2 => 3
```

The `edges` function operates exactly as before, only that if multiple edges exist, they are returned one by one.
To differentiate between the edges you can use the `asmultiedge` function:

```jldoctest walkthrough 
julia> asmultiedges(edges(mg))
5-element Vector{SingleMultiEdge{Int64}}:
 1-th Edge 1 => 2
 2-th Edge 1 => 2
 1-th Edge 1 => 3
 2-th Edge 1 => 3
 1-th Edge 2 => 3
```

To query the multiplicity of an edge you can use the `multiplicity` function

```jldoctest walkthrough 
julia> multiplicity(mg, Edge(1,2))
2
```

If you have problems with the interface you can open an issue and in the meantime  access the wrapped struct:
```
julia> getgraph(mg)
{3, 5} undirected simple Int64 graph
```
However, know that the wrapped graph might be in a corrupted state for the Graphs.jl to fully process.

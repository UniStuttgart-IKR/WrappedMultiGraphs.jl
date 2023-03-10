# WMultiGraphs.jl

A simplistic julia package implementing multi graphs.
This package aims to be fully compliant with [Graphs.jl](https://github.com/JuliaGraphs/Graphs.jl).

## Implementation
To support multigraphs very little changes need to be made in the source code of [Graphs.jl](https://github.com/JuliaGraphs/Graphs.jl).
Since the code needed is extremely similar to Graphs.SimpleGraphs we wrap a `SimpleGraph` type in a `MultiGraph` type (similarly for `SimpleDiGraph`).
Otherwise extreme code repetition is needed.
Instead we use composition and forward useful functions.
At the moment there is not a clean way to conduct an exhaustive forwarding.
So we do that traditionally be manually specifying and forwarding the needed functions.
No big brain things.

Use `graph()` to access the underlying wrapped graph.
**Attention**: we also wrap `getproperty`, so the dot syntax returns fields of the wrapped struct.

Basically, this package kills this [if statement](https://github.com/JuliaGraphs/Graphs.jl/blob/c4360cfaca3936c3d3f784063ad312205cb4fdfe/src/SimpleGraphs/simplegraph.jl#L444) and deals with the repercussions.
The function `edges()` will return `AbstractEdge`that will repeat if there are multiple edges.
Use the [`asmultiedges`](@ref) to convert the edges into a collection of [`SingleMultiEdge`](@ref).

### Similar packages and differences
- [Multigraphs.jl](https://github.com/QuantumBFS/Multigraphs.jl)
 - uses `Dict` instead of `Vector` to enumerate nodes and connections.
 - defines and solely uses an Edge type `MultipleEdge`
 - doesn't wrap Simple(Di)Graph

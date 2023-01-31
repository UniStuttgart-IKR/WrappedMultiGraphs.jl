# MultiGraphs.jl

A simplistic julia package implementing multi graphs.
This package aims to be fully compliant with [Graphs.jl](https://github.com/JuliaGraphs/Graphs.jl).

## Implementation
Since the code needed is extremely similar to Graphs.SimpleGraphs we wrap a `SimpleGraph` type in a `MultiGraph` type.
Otherwise extreme code repetition is needed.
Instead we use composition and forward useful functions.
Use `graph()` to access the underlying wrapped graph.
Attentions: we also wrap `getproperty`, so the dot syntax returns fields of the wrapped struct.

Basically, this package kills this [if statement](https://github.com/JuliaGraphs/Graphs.jl/blob/c4360cfaca3936c3d3f784063ad312205cb4fdfe/src/SimpleGraphs/simplegraph.jl#L444) and deals with the repercussions.
The function `edges()` will return `AbstractEdge`that will repeat if there are multiple edges.

### Similar packages and differences
- [Multigraphs.jl](https://github.com/QuantumBFS/Multigraphs.jl)
 - uses `Dict` instead of `Vector` to enumerate nodes and connections.
 - defines a new Edge type `MultipleEdge`

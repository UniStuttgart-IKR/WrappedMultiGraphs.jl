"""
$(TYPEDSIGNATURES)

Get the multiplicity, i.e. the number, of an edge with source `s` and destination `d`.
"""
multiplicity(mg::MultiGraph, s::T, d::T) where T<:Integer = multiplicity(mg, undirectededge(Edge(s, d)))
multiplicity(mg::MultiDiGraph, s::T, d::T) where T<:Integer = multiplicity(mg, Edge(s, d))

"""
$(TYPEDSIGNATURES)

Get the multiplicity, i.e. the number, of the edge `e`
"""
multiplicity(mg::MultiDiGraph, e::Edge) = count(==(e), edges(mg))
multiplicity(mg::MultiGraph, e::Edge) = count(==(undirectededge(e)), edges(mg))

"""
$(TYPEDSIGNATURES)

Get a collection of `SingleMultiEdge` from the `edgs`
"""
function asmultiedges(edgs)
    counts = Dict(ed => 0 for ed in edgs)
    [let
         counts[ed] += 1
         SingleMultiEdge(ed, counts[ed]) 
     end for ed in edgs]
end

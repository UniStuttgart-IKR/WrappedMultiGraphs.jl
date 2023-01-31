multiplicity(mg::AbstractMultiGraph, s::T, d::T) where T<:Integer = multiplicity(mg, Edge(s, d))
multiplicity(mg::AbstractMultiGraph, e::Edge) = count(==(e), edges(mg))


module WMultiGraphs

export MultiGraph, MultiDiGraph, SingleMultiEdge, multiplicity, asmultiedges, todirected, toundirected, getgraph

using Graphs, DocStringExtensions
import Graphs: eltype, edgetype, vertices, ne, has_edge, add_vertex!, add_vertices!, add_edge!, rem_edge!, is_directed, all_neighbors, inneighbors, outneighbors, neighbors, rem_vertex!, rem_vertices!, adjacency_matrix
import Graphs.SimpleGraphs: AbstractSimpleGraph, SimpleGraphEdge, SimpleDiGraphEdge, badj, adj, AbstractSimpleEdge, SimpleEdge

import Base:
    eltype, show, ==, Pair, Tuple, copy, length, issubset, reverse, zero, in, iterate, hash


import LinearAlgebra: issymmetric

include("abstractmultigraph.jl")
include("multiedge.jl")
include("multigraph.jl")
include("multidigraph.jl")
include("more.jl")

end

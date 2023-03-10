using WrappedMultiGraphs, Graphs
using Test, TestSetExtensions

@testset "WrappedMultiGraphs.jl" begin
    @includetests ["graphs", "more"]
end

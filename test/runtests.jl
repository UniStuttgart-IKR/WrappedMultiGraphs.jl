using MultiGraphs, Graphs
using Test, TestSetExtensions

@testset "MultiGraphs.jl" begin
    @includetests ["graphs", "more"]
end

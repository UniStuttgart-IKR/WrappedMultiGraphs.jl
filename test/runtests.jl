using WMultiGraphs, Graphs
using Test, TestSetExtensions

@testset "WMultiGraphs.jl" begin
    @includetests ["graphs", "more"]
end

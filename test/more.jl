@testset "more" begin
    # unidirectional
    mg = MultiGraph(complete_graph(3))
    add_edge!(mg, 1, 2)
    add_edge!(mg, 2, 1)
    @test multiplicity(mg, 1, 2) == multiplicity(mg, Edge(1,2)) == 3
    @test multiplicity(mg, 2, 1) == multiplicity(mg, Edge(2,1)) == 3

    # bidirectional
    mdg = MultiDiGraph(SimpleDiGraph(complete_graph(3)))
    add_edge!(mdg, 1, 2)
    add_edge!(mdg, 2, 1)
    @test multiplicity(mdg, 1, 2) == 2
    @test multiplicity(mdg, 2, 1) == 2
end

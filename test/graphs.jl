@testset "unidirectional" begin
    @test try MultiGraph(); true; catch e; false end
    @test try MultiGraph(0); true; catch e; false end
    @test try MultiGraph(10); true; catch e; false end
    @test try MultiGraph{Int}(); true; catch e; false end
    @test try MultiGraph{Int}(0); true; catch e; false end
    @test try MultiGraph{Int}(10); true; catch e; false end

    mg = MultiGraph(3)
    @test add_vertex!(mg)
    @test add_vertex!(mg)
    @test add_edge!(mg, 1, 2)
    @test add_edge!(mg, Edge(1, 2))
    @test add_edge!(mg, Edge(2, 1))
    @test length(edges(mg)) == 3
    @test all(x -> x == first(edges(mg)), edges(mg))
    @test add_edge!(mg, Edge(1, 3))
    @test inneighbors(mg, 1) == [2,3]
    @test outneighbors(mg, 1) == [2,3]
    @test all_neighbors(mg, 1) == [2,3]

    @test rem_edge!(mg, 1, 2)
    @test rem_edge!(mg, Edge(1, 2))
    @test rem_edge!(mg, 1, 2)
    @test !rem_edge!(mg, 1, 2)
    @test rem_vertices!(mg, [1,3]) == [5,2,4]
    @test rem_vertex!(mg, 1)
    @test !rem_vertex!(mg, 3)
end

@testset "bidirectional" begin
    @test try MultiDiGraph(); true; catch e; false end
    @test try MultiDiGraph(0); true; catch e; false end
    @test try MultiDiGraph(10); true; catch e; false end
    @test try MultiDiGraph{Int}(); true; catch e; false end
    @test try MultiDiGraph{Int}(0); true; catch e; false end
    @test try MultiDiGraph{Int}(10); true; catch e; false end

    mdg = MultiDiGraph(3)
    @test add_vertex!(mdg)
    @test add_vertex!(mdg)
    @test add_edge!(mdg, 1, 2)
    @test add_edge!(mdg, Edge(1, 2))
    @test add_edge!(mdg, Edge(2, 1))
    @test length(edges(mdg)) == 3
    @test !all(x -> x == first(edges(mdg)), edges(mdg))
    @test add_edge!(mdg, Edge(1, 3))
    @test inneighbors(mdg, 1) == [2]
    @test outneighbors(mdg, 1) == [2,3]
    @test all_neighbors(mdg, 1) == [2,3]
end

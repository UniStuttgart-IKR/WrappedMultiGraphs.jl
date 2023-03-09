using Documenter, MultiGraphs, Graphs

makedocs(sitename="MultiGraphs.jl",
    pages = [
        "Introduction" => "index.md",
        "Usage and Examples" => "usage.md",
        "API" => "API.md"
    ])

deploydocs(
    repo = "github.com/UniStuttgart-IKR/MultiGraphs.jl.git",
)

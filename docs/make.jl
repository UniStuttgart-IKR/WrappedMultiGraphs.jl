using Documenter, WMultiGraphs, Graphs

makedocs(sitename="WMultiGraphs.jl",
    pages = [
        "Introduction" => "index.md",
        "Usage and Examples" => "usage.md",
        "API" => "API.md"
    ])

deploydocs(
    repo = "github.com/UniStuttgart-IKR/WMultiGraphs.jl.git",
)

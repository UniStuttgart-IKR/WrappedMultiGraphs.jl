using Documenter, WrappedMultiGraphs, Graphs

makedocs(sitename="WrappedMultiGraphs.jl",
    pages = [
        "Introduction" => "index.md",
        "Usage and Examples" => "usage.md",
        "API" => "API.md"
    ])

deploydocs(
    repo = "github.com/UniStuttgart-IKR/WrappedMultiGraphs.jl.git",
)

using Texstan
using Documenter

DocMeta.setdocmeta!(Texstan, :DocTestSetup, :(using Texstan); recursive=true)

makedocs(;
    modules=[Texstan],
    authors="Paulo José Saiz Jabardo",
    repo="https://github.com/pjsjipt/Texstan.jl/blob/{commit}{path}#{line}",
    sitename="Texstan.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        edit_link="main",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
)

using CSV
using DataFrames

data = CSV.read("input", DataFrame; header=["left", "", "", "right"])

println("part A")
sort!(data[!, :left])
sort!(data[!, :right])
println(reduce(+, map(row -> max(row.left, row.right) - min(row.left, row.right), eachrow(data))))

println("part B")

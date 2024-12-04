
function a(grid)
    n = length(grid)
    res = 0
    map(a -> map(i -> grid[1+i][a+i], 0:(n-a)), 1:n) |> collect |> println
    return 1
end

grid = read("input", String) |> strip |> s -> split(s, "\n")
println("part A")
grid |> a |> println
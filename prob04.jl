function countXMAS(str)
    return count("XMAS", str) + count("SAMX", str)
end

function a(grid)
    n = length(grid)
    res = 0
    return countXMAS.(
        [
            map(a -> String(collect(map(i -> grid[1+i][a+i], 0:(n-a)))), 1:n);
            map(a -> String(collect(map(i -> grid[a+i][1+i], 0:(n-a)))), 2:n);
            map(a -> String(collect(map(i -> grid[1+i][a-i], 0:(a-1)))), 1:n);
            map(a -> String(collect(map(i -> grid[a+i][n-i], 0:(n-a)))), 2:n);
            map(a -> String(collect(map(i -> grid[i][a], 1:n))), 1:n);
            grid
        ]) |> sum
end

grid = read("input", String) |> strip |> s -> split(s, "\n")
println("part A")
grid |> a |> println

function isSAM(str)
    return str == "SAM" || str == "MAS"
end

function b(grid)
    n = length(grid)
    res = 0
    for i in 2:(n-1)
        for j in 2:(n-1)
            if isSAM(String(collect([grid[i-1][j-1], grid[i][j], grid[i+1][j+1]]))) && isSAM(String(collect([grid[i-1][j+1], grid[i][j], grid[i+1][j-1]])))
                res += 1
            end
        end
    end
    return res
end

println("part B")
grid |> b |> println
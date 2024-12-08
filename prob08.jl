
function read_input()
    res = Dict{Char,Vector{Vector{Int64}}}()
    input = read("input", String) |> (s -> split(strip(s), "\n"))
    for (i, row) in input |> enumerate
        for (j, c) in row |> collect |> enumerate
            if c != '.'
                if haskey(res, c)
                    push!(res[c], [i; j])
                else
                    res[c] = [[i; j]]
                end
            end
        end
    end
    println(input)
    println(input[1])
    return (res, length(input), length(input[1]))
end

function a(input, m, n)
    antinodes = Vector{Vector{Int64}}()
    for (c, nodes) in input
        for (i, a) in enumerate(nodes)
            for (j, b) in enumerate(nodes)
                if (i != j) && (1 <= minimum(2 * a - b)) && (0 <= minimum([m; n] - (2 * a - b)))
                    push!(antinodes, 2 * a - b)
                end
                if (i != j) && (1 <= minimum(2 * b - a)) && (0 <= minimum([m; n] - (2 * b - a)))
                    push!(antinodes, 2 * b - a)
                end
            end
        end
    end
    return length(unique(antinodes))
end

println("part A")
input, m, n = read_input()
println(a(input, m, n))
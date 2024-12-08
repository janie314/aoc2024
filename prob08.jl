
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

function reduce(v)
    return Int.([v[1]; v[2]] / gcd(v[1], v[2]))
end

function b(input, m, n)
    antinodes = Vector{Vector{Int64}}()
    for (c, nodes) in input
        for (i, a) in enumerate(nodes)
            for (j, b) in enumerate(nodes)
                k = 1
                added = true
                while added
                    added = false
                    if (i != j) && (1 <= minimum(b + k * reduce(a - b))) && (0 <= minimum([m; n] - (b + k * reduce(a - b))))
                        added = true
                        push!(antinodes, b + k * reduce(a - b))
                    end
                    if (i != j) && (1 <= minimum(a + k * reduce(b - a))) && (0 <= minimum([m; n] - (a + k * reduce(b - a))))
                        added = true
                        push!(antinodes, a + k * reduce(b - a))
                    end
                    k += 1
                end
            end
        end
    end
    return unique(antinodes)
end

println("part B")
println(length(b(input, m, n)))
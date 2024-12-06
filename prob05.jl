
function atoi(str)
    return parse(Int, str)
end

function leq(a, b, lookup)
    return get(lookup, (a, b), 0) == 1
end

function compute_row(v, lookup)
    for i in 1:length(v)-1
        if !leq(v[i], v[i+1], lookup)
            return 0
        end
    end
    return v[Int((length(v) + 1) / 2)]
end

function read_rules()
    parts = split(read("input", String), "\n\n")
    return parts[1] |>
           (s -> split(s, "\n")) |>
           (v -> map(s -> [atoi.(split(s, "|")) |> Tuple; 1], v)) |>
           Dict
end

function read_input()
    return split(read("input", String), "\n\n")[2] |>
           (s -> split(s, "\n")) |>
           (v -> filter(s -> length(s) != 0, v)) |>
           (v -> map(s -> atoi.(split(s, ",")), v))
end

function a(input, rules)
    return sum(row -> compute_row(row, rules), input)
end

println("part A")
rules = read_rules()
input = read_input()
println(a(input, rules))

function b(input, rules)
    newinput = filter(row -> compute_row(row, rules) == 0, input)
    return a(map(row -> sort(row, lt=((a, b) -> leq(a, b, rules))), newinput), rules)
end

println("part B")
println(b(input, rules))
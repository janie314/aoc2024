function atoi(str)
    return parse(Int128, str)
end

function can_do(row, goal)
    if length(row) == 1
        return row[1] == goal
    else
        return can_do([row[1] + row[2]; row[3:end]], goal) ||
               can_do([row[1] * row[2]; row[3:end]], goal)
    end
end

function read_input()
    return read("input", String) |>
           (s -> split(strip(s), "\n")) |>
           (v -> map(row -> atoi.(split(replace(row, ":" => ""), " ")), v))
end

function a(input)
    res = 0
    for row in input
        if can_do(row[2:end], row[1])
            res += row[1]
        end
    end
    return res
end


println("part A")
input = read_input()
println(a(input))

function newop(a, b)
    return atoi("$a$b")
end

function can_do2(row, goal)
    if row[1] > goal
        return false
    elseif length(row) == 1
        return row[1] == goal
    else
        return can_do2([row[1] + row[2]; row[3:end]], goal) ||
               can_do2([row[1] * row[2]; row[3:end]], goal) ||
               can_do2([newop(row[1], row[2]); row[3:end]], goal)
    end
end

function b(input)
    res = 0
    for row in input
        if can_do2(row[2:end], row[1])
            res += row[1]
        end
    end
    return res
end

println("part B")
input = read_input()
println(b(input))
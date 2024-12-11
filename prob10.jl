function atoi(str)
    return parse(Int128, str)
end

function read_input()
    text = strip(read("input", String))
    split(text, "\n")
end

function climb(input, (i, j), k)
    if !((1 <= i <= length(input)) && (1 <= j <= length(input[1])))
        nothing
    elseif atoi(input[i][j]) != k
        nothing
    elseif k == 9
        [(i, j)]
    else
        [climb(input, (i - 1, j), k + 1); climb(input, (i + 1, j), k + 1); climb(input, (i, j - 1), k + 1); climb(input, (i, j + 1), k + 1)]
    end
end

function a(input)
    res = 0
    for (i, row) in enumerate(input)
        for j in findall('0', row)
            println("start: $i,$j")
            res += length(unique(filter(s -> !isnothing(s), climb(input, (i, j), 0))))
        end
    end
    res
end

println("part A")
println(a(read_input()))
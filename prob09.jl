function atoi(str)
    return parse(Int128, str)
end

function read_input()
    text = strip(read("input", String))
    disk = Vector{Int128}()
    for i in 1:2:length(text)
        disk = [disk; map((n) -> Int128((i - 1) / 2), 1:atoi(text[i]))]
        if i + 1 <= length(text)
            disk = [disk; map((n) -> -1, 1:atoi(text[i+1]))]
        end
    end
    disk
end

function checksum(v)
    res = 0
    for (i, x) in enumerate(v)
        res += (i - 1) * x
    end
    res
end

function a(input)
    for i = length(input):-1:1
        if input[i] != -1
            k = findfirst(x -> x == -1, input)
            if k < i
                input[k] = input[i]
                input[i] = -1
            else
                break
            end
        end
        # println(join(map(x -> x == -1 ? '.' : x, input)))
    end
    return checksum(filter(x -> x != -1, input))
end

println("part A")
println(a(read_input()))
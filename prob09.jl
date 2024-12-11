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

function read_input2()
    text = strip(read("input", String))
    disk = Vector{Tuple{Int128,Int128}}()
    for i in 1:2:length(text)
        disk = [disk; (Int128((i - 1) / 2), atoi(text[i]))]
        if i + 1 <= length(text)
            disk = [disk; (-1, atoi(text[i+1]))]
        end
    end
    disk
end

function checksum2(v)
    res = 0
    k = 0
    for (m, len) in v
        for i in 1:len
            if m != -1
                res += m * k
            end
            k += 1
        end
    end
    res
end


function b(input)
    for i = length(input):-1:1
        n, len = input[i]
        if n != -1
            k = findfirst(input) do (m, emptylen)
                m == -1 && len <= emptylen
            end
            if !isnothing(k) && k < i
                _, emptylen = input[k]
                input = [input[1:k-1]; [(n, len), (-1, emptylen - len)]; input[k+1:i-1]; [(-1, len)]; input[i+1:end]]
            end
        end
    end
    return checksum2(filter(input) do (m, len)
        len != 0
    end)
end

println("part B")
println(b(read_input2()))
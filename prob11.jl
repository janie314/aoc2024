function atoi(str)
    return parse(Int128, str)
end

function change(n)
    if n == 0
        [1]
    elseif length(string(n)) % 2 == 0
        len = length(string(n))
        k = Int128(len / 2)
        atoi.([string(n)[1:k], string(n)[k+1:end]])
    else
        [n * 2024]
    end
end

function read_input()
    atoi.(split(read("input", String), ' '))
end

function a(input, k)
    for i in 1:k
        input = collect(Iterators.flatten(change.(input)))
    end
    input
end

function b(input)
    lookup = Dict{Int128,Vector{Int128}}()
    lookup_len = Dict{Int128,Int128}()
    sum = 0
    for n in a(input, 25)
        input2 = Vector{Int128}()
        if !haskey(lookup, n)
            lookup[n] = a([n], 25)
            lookup_len[n] = length(lookup[n])
        end
        for m in lookup[n]
            if !haskey(lookup_len, m)
                lookup_len[m] = length(a([m], 25))
            end
            sum += lookup_len[m]
        end
    end
    sum
end

println("part A")
println(length(a(read_input(), 25)))

println("part B")
println(b(read_input()))
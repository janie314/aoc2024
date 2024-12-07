lookup = Dict{Tuple{Int64,Int64},Int64}()
lookup[(1, 2)] = 3
println(get(lookup, (1, 2), 0))
println(get(lookup, (1, 4), 0))
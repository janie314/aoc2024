using CSV
using DataFrames

data = CSV.read("input", DataFrame, header=false, delim=' ', silencewarnings=true)

function ok(arr)
    b = maximum(([0; arr]-[arr; 0])[2:end-1])
    a = minimum(([0; arr]-[arr; 0])[2:end-1])
    return (-3 <= a <= b <= -1) || (1 <= a <= b <= 3)
end

println("part A")
global count = 0
for row in eachrow(data)
    if ok(filter(x -> !ismissing(x), Vector(row[:])))
        global count += 1
    end
end
count |> println

function ok2(arr)
    return ok(arr) || reduce((a, b) -> a || b, map(i -> ok([arr[1:i-1]; arr[i+1:end]]), 1:length(arr)))
end

println("part B")
global count = 0
for row in eachrow(data)
    if ok2(filter(x -> !ismissing(x), Vector(row[:])))
        global count += 1
    end
end
count |> println
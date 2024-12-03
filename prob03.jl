
function a(text)
    matches = eachmatch(r"mul\([0-9]+,[0-9]+\)", text)
    res = 0
    for match in matches
        numbers = replace(match.match, "mul(" => "", ")" => "") |> v -> split(v, ',') |> n -> parse.(Int, n)
        num1, num2 = numbers
        res += num1 * num2
    end
    return res
end


function b(text)
    while length(findall(r"don't", text)) != 0
        text = replace(text, r"don't\(\)[^d]+" => "")
    end
    return a(text)
end

text = read("input", String)
println("part A")
a(text) |> println
println("part B")
b(text) |> println
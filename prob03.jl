
function a(text)
    matches = eachmatch(r"mul\([0-9]+,[0-9]+\)", text)
    total_product = 0

    for match in matches
        numbers = replace(match.match, "mul(" => "", ")" => "") |> v -> split(v, ',') |> x -> parse.(Int, x)
        num1, num2 = numbers
        total_product += num1 * num2
    end

    return total_product
end


function b(text)
    while length(findall(r"don't", text)) != 0
        println("joe")
        text = replace(text, r"don't\(\)[^d]+" => "")
    end

    return a(text)
end

text = read("input", String)
println("part A")
a(text) |> println
println("part B")
b(text) |> println
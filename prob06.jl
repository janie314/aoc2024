rot = [0 1; -1 0]

function read_input()
    return filter(s -> length(s) != 0,
        read("input", String) |>
        (s -> split(s, "\n")))
end

function starting_pos(input)
    for (i, row) in enumerate(input)
        j = findfirst('^', row)
        if !isnothing(j)
            return (i, j)
        end
    end
end

function a(input)
    n = length(input)
    i, j = starting_pos(input)
    xdir, ydir = -1, 0
    pos_list = []
    while (1 <= i <= n) && (1 <= j <= n)
        if (1 <= i + xdir <= n) && (1 <= j + ydir <= n) && (input[i+xdir][j+ydir] == '#')
            xdir, ydir = rot * [xdir; ydir]
        else
            pos_list = [pos_list; (i, j)]
            i, j = [i; j] + [xdir; ydir]
        end
    end
    return pos_list |> unique
end

println("print A")
input = read_input()
n = input |> length
input |> a |> length |> println

function a_modified(input, (xobs, yobs))
    n = length(input)
    i, j = starting_pos(input)
    xdir, ydir = -1, 0
    pos_list = []
    pos_dir_lookup = Dict{Tuple{Int64,Int64,Int64,Int64},Bool}()
    while (1 <= i <= n) && (1 <= j <= n)
        if get(pos_dir_lookup, (i, j, xdir, ydir), false)
            return 1
        elseif (1 <= i + xdir <= n) && (1 <= j + ydir <= n) && (
                   (input[i+xdir][j+ydir] == '#') ||
                   (i + xdir == xobs && j + ydir == yobs))
            xdir, ydir = rot * [xdir; ydir]
        else
            pos_list = [pos_list; (i, j)]
            pos_dir_lookup[(i, j, xdir, ydir)] = true
            i, j = [i; j] + [xdir; ydir]
        end
    end
    return 0
end

function b(input)
    pos_list = a(input)
    sum = 0
    for (i, j) in pos_list
        println(i, ",", j)
        sum += a_modified(input, (i, j))
        println(sum)
    end
    return sum
end

println("print B")
input |> b |> println
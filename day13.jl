# Day 13 AOC 2021
# maziyank@github.com

input = readlines(open("day13.txt", "r"))
fold_points = map(x->(x[1][length(x[1])], parse(Int,x[2])), split.(filter(x-> occursin("fold", x), input), "="))
dots_coordinate = map(x->Tuple(parse.(Int,x)) ,split.(filter(x-> occursin(",", x), input), ","))

function fold_y(fd, dots)
    a = Set(filter(x->x[2] < fd, dots))
    b = Set(map(x-> (x[1], fd*2 - x[2]), filter(x->x[2] > fd, dots)))
    a_b = push!(a, b...)
    [x for x in filter(x->x[2] != fd, a_b)]
end

function fold_x(fd, dots)
    a = Set(filter(x->x[1] < fd, dots))
    b = Set(map(x-> (fd*2 - x[1], x[2]), filter(x->x[1] > fd, dots)))
    a_b = push!(a, b...)
    [x for x in filter(x->x[1] != fd, a_b)]
end

# Part 1
(kind,value) = fold_points[1]
_1st_fold = kind == 'x' ? fold_x(value, dots_coordinate) : fold_y(value, dots_coordinate)
println("Part 1: ", length(_1st_fold))

# Part 2
flipped = copy(dots_coordinate)
for (kind,value) in fold_points        
    flipped = kind == 'x' ? fold_x(value, flipped) : fold_y(value, flipped)        
end

draw = fill(".", reverse(maximum(flipped)) .+ 1 )
for (x,y) in flipped
   draw[y+1,x+1]  = "#"
end

println("Part 2: Secret Code \n")
for i in 1:size(draw)[1]
    println(join(draw[i, 1:size(draw)[2]]))
end
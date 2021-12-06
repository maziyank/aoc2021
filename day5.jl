# Day 5 AOC 2021
# maziyank@github.com

contents = readlines(open("day5.txt", "r"))
vents = [parse.(Int,split(replace(content, " -> " => ","), ",")) for content in contents]

# part 1

## filter data
part1_vents = filter(x-> x[1] == x[3] || x[2] == x[4] , vents)
part1_vents

## setup board
board_size = maximum(vcat(part1_vents...)) + 1
board = zeros(Int8, board_size, board_size)

#iterate
for vent in part1_vents    
    vent .+= 1
    y1, x1, y2, x2 = vent
    board[range(x1, x2, step= x1>=x2 ? -1 : 1), range(y1,y2, step= y1>=y2 ? -1 : 1)] .+= 1 
end

println("Part 1: ",count(x->x > 1, board))

# part 2
## filter data
part2_vents = filter(x-> abs(x[1] - x[3]) == abs(x[2] - x[4]) , vents)

#iterate
for vent in part2_vents    
    vent .+= 1
    y1, x1, y2, x2 = vent    
    move1 = range(x1,x2, step= x1>=x2 ? -1 : 1)
    move2 = range(y1,y2, step= y1>=y2 ? -1 : 1)
    
    for i in 1:length(move1)
        board[move1[i], move2[i]] += 1 
    end
end

println("Part 2: ",count(x->x > 1, board))
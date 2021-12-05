# Day 2 AOC 2021
# maziyank@github.com

input = open("day2.txt", "r")
steps = [split(step) for step in readlines(input)] 

# part1 
depth = 0; hor = 0;
for step in steps
    x = parse(Int64, step[2])
    if step[1] == "forward"
        global hor += x
    elseif step[1] == "up"
        global depth -= x
    elseif step[1] == "down"
        global depth += x
    end            
end

println("Part 1: ", depth * hor)

# part2
depth2 = 0; hor2 = 0; aim = 0
for step in steps
    x = parse(Int64, step[2])
    if step[1] == "forward"
        global hor2 += x
        global depth2 += aim*x
    elseif step[1] == "up"
        global aim -= x
    elseif step[1] == "down"
        global aim += x
    end            
end

println("Part 2: ", depth2 * hor2) 
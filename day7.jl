# Day 7 AOC 2021
# maziyank@github.com

input = readlines(open("day7.txt", "r"))
crabs = parse.(Int16, split(first(input),","))
max_pos = maximum(crabs)

#part 1
result = [sum(abs.(crabs .- target)) for target in 1:max_pos]
println("Part 1: ", minimum(result))

#part 2
result2 = [sum(sum.(range.(0,abs.(crabs .- target),step=1))) for target in 1:max_pos]
println("Part 2: ", minimum(result2))

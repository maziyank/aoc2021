# Day 1 AOC 2021
# maziyank@github.com

input = open("day1.txt", "r")
numbers = [parse(Int64, num) for num in readlines(input)]

function count_increment(numbers,skip=1)
    increment = 0
    for i in skip+1:length(numbers)
        increment += numbers[i] > numbers[i-skip] ? 1 : 0                    
    end  
    
    increment
end

println("Part 1: ",count_increment(numbers, 1))
println("Part 2: ", count_increment(numbers, 3)) 
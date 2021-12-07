# Day 6 AOC 2021
# maziyank@github.com

# part 1
input = readlines(open("sample.txt", "r"))
numbers = parse.(Int8, split(first(input),","))
cycle(num) = num == 0 ? 6 : num - 1

function part1(initial, days)
    for day in 1:days
        to_add = fill(8, count(x-> x==0, initial))
        initial = cycle.(initial)    
        if length(to_add) > 0
            initial = vcat(initial, to_add)
        end        
    end
    
    length(initial)
end

println("Part 1:", part1(numbers, 80))

# part 2
function part2(numbers, last_day=256)
    days = fill(0, 9)    
    days = [count(x->day==x, numbers) for day in 1:9]        
    for i in 0:last_day-2
        days[(i % 9 + 7) % 9 + 1] += days[i % 9+1]
    end    
    sum(days)
end

println("Part 2:", part2(numbers))
# Day 3 AOC 2021
# maziyank@github.com

input = open("day3.txt", "r")
numbers = [split(x,"") for x in readlines(input)]
len_x = length(first(numbers)); len_y = length(numbers)

# part 1
gamma = Vector{Bool}(); epsilon = Vector{Bool}()
for i in 1:len_x
    curr = Vector{Bool}()
    for j in 1:len_y
       append!(curr, parse(Bool,numbers[j][i])) 
    end
        
    append!(gamma, count(curr) > len_y - count(curr));     
end

epsilon = .!gamma
answer1 = parse(Int, join(map(x -> string(convert(Int64, x)), gamma)), base= 2) * parse(Int, join(map(x -> string(convert(Int64, x)), epsilon)), base= 2)
println("Part 1:", answer1)


#part 2
function get_residual(nums, oxygen = true)
    eliminated = copy(nums)
    for i in 1:len_x     
         curr = Vector{Bool}(); len_y = length(eliminated)
         for j in 1: len_y; append!(curr, parse(Bool,eliminated[j][i])); end
         
         if count(curr) >= len_y - count(curr)
             eliminated = oxygen ? eliminated[curr] : eliminated[.!curr]
         else
             eliminated = oxygen ? eliminated[.!curr] : eliminated[curr]; 
         end
         
         if length(eliminated) == 1; break; end;
     end 
     
     parse(Int,join(first(eliminated)), base=2)
 end
 
 answer2 = get_residual(numbers, true) * get_residual(numbers, false)
 println("Part 2:", answer2)
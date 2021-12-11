# Day 9 AOC 2021
# maziyank@github.com

]input = readlines(open("day9.txt", "r"))
heights = [parse.(Int8,x) for x in split.(input,"")]
temp_map = transpose(hcat(heights...))
the_map = fill(100,size(temp_map).+2)
the_map[2:size(the_map)[1]-1,2:size(the_map)[2]-1] = temp_map

# Part 1
risk_level = Dict()
for i in 2:size(the_map)[1]-1
    for j in 2:size(the_map)[2]-1
        adjacents = the_map[i-1:i+1,j-1:j+1]        
        adjacents = map(x-> Int(x > adjacents[2,2]),adjacents)
        adjacents[2,2] = 1    
        if sum(adjacents) == 9
            risk_level[(i,j)] = the_map[i,j] + 1
        end
    end
end    

println("Part 1: ", sum(values(risk_level)))

# part 2 
function check_basin(i,j,maps,basin)
    found_basin = Set()
    for (x,y) in map(x-> x .+ (i,j), [(1,0),(0,1),(-1,0),(0,-1)])  
        if (x,y) in basin
            continue
        end
        
        try           
           if (maps[x,y] < 9) && (1 < x < size(maps)[1]) && (1 < y < size(maps)[2])                                              
                push!(found_basin, (x,y))                
           end
        catch e
           continue 
        end
    end
        
    for (k,l) in found_basin
        push!(basin, (k,l))
        check_basin(k,l,maps,basin)
    end
    
    basin    
end

basins = []
for (i,j) in keys(risk_level)
    basin = Set()
    check_basin(i,j,the_map,basin)
    append!(basins, length(basin))
end

largest_basin = sort(basins, rev=true)[1:3]
println("Part 2: ", prod(largest_basin))
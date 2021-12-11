# Day 11 AOC 2021
# maziyank@github.com

input = readlines(open("day11.txt", "r"))
octopuses = transpose(hcat([parse.(Int8,x) for x in split.(input,"")]...))

# Part 1
adj_matrix= []
for i in -1:1; for j in -1:1; push!(adj_matrix, (i,j)); end; end;
filter!(x -> x != (0,0), adj_matrix)

function step(input, neighbours)
    flashes = Set()    
    # increases by 1
    data = copy(input)
    data .+= 1
    # flashing
    next_flash = Set([(x[1],x[2]) for x in findall(x->x == 10, data)])    
    while length(next_flash) > 0                      
        for (i,j) in next_flash                
            push!(flashes, pop!(next_flash, (i,j)))                                                                       
            for (x,y) in neighbours    
                try
                    data[i+x,j+y] += 1; 
                    if data[i+x,j+y] == 10 && (i+x,j+y) ∉ flashes 
                       push!(next_flash, (i+x,j+y))   
                    end
                catch e continue end;                
            end
        end        
    end
        
    # set flashes octopus to 0
    for (i,j) in flashes
       data[i,j] = 0
    end
    
    return length(flashes), data
end

number_flash = []
flashed_octopus = copy(octopuses)
for i in 1:100   
    result = step(flashed_octopus, adj_matrix)    
    global flashed_octopus = result[2]
    append!(number_flash, flashed_octopus[1])    
end;

println("Part 1:", sum(number_flash))

# Part 2
x = 0; target = prod(size(octopuses))
flashed_octopus2 = copy(octopuses); max_try = 300;
while x < max_try
    global x += 1
    result = step(flashed_octopus2, adj_matrix)      
    global flashed_octopus2 = result[2]       
    if result[1] == target
        println("Part 2:", x)
        break
    end    
end
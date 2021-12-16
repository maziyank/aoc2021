## I will apply djikstra
using DataStructures

input = readlines(open("day15.txt", "r"))
cavern = transpose(hcat([parse.(Int64,x) for x in split.(input,"")]...))

# Implement Djikstra Algorithm

# Part 1
function djikstra(graph, source)
    distance  = fill(Inf,size(graph))
    distance[source...] = 0
    queue = MutableBinaryMinHeap([(0, source)])
    
    while length(queue) > 0
       v_dist, v = pop!(queue)
       distance[v...] =  v_dist  
                   
       adj_matrix = [(0,1),(1,0),(0,-1),(-1,0)]
       neighbours = map(x->x.+ v,adj_matrix)   
       neighbours = filter(p -> all(p .>= (1,1)) && all(p .<= size(graph)), neighbours)
       for w in neighbours
            vw_dist = v_dist + graph[w...]
            if vw_dist <  distance[w...] 
                distance[w...] = vw_dist
                push!(queue, (vw_dist, w))      
            end
       end     
                
    end
    
    distance
end

distance = djikstra(cavern, (1,1))
println("Part 1: ", distance[size(cavern)...])

# Part 2
function djikstra2(cavern, source, factor=5)
    new_cavern = fill(0,size(cavern) .* factor)
    for i in 0:factor-1
        for j in 0:factor-1
            a, b = (i*(size(cavern)[1])+1):(i+1)*(size(cavern)[1]), (j*(size(cavern)[2])+1):(j+1)*(size(cavern)[2])    
            increased_tile = (cavern .+ (i+j)) 
            new_cavern[a,b] = map(x-> x > 9 ? x - 9 : x, increased_tile)
        end
    end
    
    djikstra(new_cavern, source)    
end

distance2 = djikstra2(cavern, (1,1), 5)
println("Part 2: ", distance2[size(distance2)...])
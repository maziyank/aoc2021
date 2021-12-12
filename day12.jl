# Day 12 AOC 2021
# maziyank@github.com

input = split.(readlines(open("day12.txt", "r")),"-")

# create dictionary for next points
a = Dict([(point[1], filter(x->x!="start", map(x->x[2], filter(x->x[1]==point[1],input)))) for point in input])
b = Dict([(point[2], filter(x->x!="start", map(x->x[1], filter(x->x[2]==point[2],input)))) for point in input])
next_points = merge(vcat, a, b)
next_points["end"] = []
routes_candidate = [["start"]]

# Helper
is_big_cave(s) = match(r"^[A-Z,\s]+$",s) !== nothing
small_cave_twice_visited(route) = 2 ∈ [count(x->x ==c, route) for c in unique(filter!(!is_big_cave, route))]

function next_possible_route(route, part=1)    
    next_routes = []
    finished_routes = []
    for next_point in next_points[last(route)]    
        skipped = (part==1 && !is_big_cave(next_point) && next_point ∈ route) || 
            (part==2 && !is_big_cave(next_point) && next_point ∈ route && small_cave_twice_visited(route))
        
        if (next_point == "end")
            push!(finished_routes, push!(copy(route), next_point))            
        elseif skipped           
            continue
        else       
            push!(next_routes, push!(copy(route), next_point))            
        end
    end    
    
    (next_routes, finished_routes)
end
    
function get_all_correct_routes()
    finished_routes = []
    routes_candidate = [["start"]]
    while length(routes_candidate)>0
       next_routes_candidate = []
       for route in routes_candidate
            (next, finished) = next_possible_route(route)        
            push!(next_routes_candidate, next...)                
            push!(finished_routes, finished...)                
       end

       routes_candidate = copy(next_routes_candidate)    

    end    
    length(finished_routes)     
end

println("Part 1:", get_all_correct_routes(1))
println("Part 2:", get_all_correct_routes(2))
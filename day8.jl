# Day 8 AOC 2021
# maziyank@github.com

input = readlines(open("day8.txt", "r"))

# Part 1
segments = split.([x[2] for x in split.(input," | ")])
segments_count = map.(length, segments)
unique_count = map.(x-> x in [2,4,7,3] ? x : 0, segments_count)
part1 = sum(count.(x->x != 0,unique_count))
println("Part 1: ", part1)

# Part 2
segments_input = split.([x[1] for x in split.(input," | ")])
known_segment = Dict( 2 => 1, 4 => 4, 7 => 8, 3 => 7 )

function guess_number(segments)
    # find 1,4,5,7
    sev_seg = Dict()
    for segment in segments
        if length(segment) in [2,4,7,3]
            sev_seg[known_segment[length(segment)]] = Set(segment)
        end
    end
    
    # guess 6 or 0 or 9       
    for segment in segments
        if length(segment)==6          
            set_069 = setdiff(sev_seg[8], Set(segment))            
            if union(set_069, sev_seg[7]) == sev_seg[7]
                sev_seg[6] = Set(segment)
            elseif union(set_069, sev_seg[4]) == sev_seg[4]
                sev_seg[0] = Set(segment)                
            else
                sev_seg[9] = Set(segment)        
            end                                             
        end 
    end
    
    # guess 2 or 3 or 5      
    for segment in segments
        if length(segment)==5          
            # 5
            if length(setdiff(sev_seg[6], Set(segment)))==1
                sev_seg[5] = Set(segment) 
            elseif length(setdiff(sev_seg[9], Set(segment)))==1
                sev_seg[3] = Set(segment) 
            else
                sev_seg[2] = Set(segment) 
            end      
        end 
    end    
    Dict(value => key for (key, value) in sev_seg)
end

guess_dicts = [guess_number(x) for x in segments_input]
result = [parse(Int16,join(map(x->guess_dicts[i][Set(x)],segments[i]))) for i in 1:length(segments_input)]
println("Part 1: ", sum(result))
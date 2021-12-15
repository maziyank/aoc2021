# Day 14 AOC 2021
# maziyank@github.com

input = readlines(open("day14.txt", "r"))
template = first(input)
rules = Dict(Tuple.(split.(filter(x-> occursin("->", x), input)," -> ")))

# Day 1
function pair_insertion(templ, rules)
    i, result = 1, ""
    while i<=length(templ)
        result = "$(result)$(templ[i])"  
        if i<length(templ) && templ[i:i+1] in keys(rules)            
            result = "$(result)$(rules[templ[i:i+1]])"        
        end
        i += 1
    end
    
    result
end

# Part 1
for i in 1:10
    global template = pair_insertion(template, rules)
end

occurence = sort([(x, count(a-> a==x, template)) for x in unique(template)], by= x -> x[2])
println("Part 1: ", last(occurence)[2] - first(occurence)[2])

# Part 2 (First approach is not feasible, Be aware of Big O!)

function pair_insertion2(pairs_dict, rules)   
    pairs_dict2 = copy(pairs_dict)
    for pair in keys(pairs_dict)       
        if pairs_dict[pair] > 0
            a = "$(first(pair))$(rules[pair])"
            pairs_dict2[a] += pairs_dict[pair]

            b = "$(rules[pair])$(last(pair))"
            pairs_dict2[b] += pairs_dict[pair]      
            
            pairs_dict2[pair] -= pairs_dict[pair] 
        end
    end        
    pairs_dict2
end

pairs_dict = Dict([(x, 0) for x in keys(rules)])
template2 = first(input)
pairs_dict_pre = Dict([(template2[x:x+1],count(template2[x:x+1],template2)) for x in 1:length(template2)-1])
for x in keys(pairs_dict_pre)
    global pairs_dict[x] = pairs_dict_pre[x]
end

for i in 1:40
    global pairs_dict = pair_insertion2(pairs_dict, rules)
end

chars_dict = Dict([(x,0) for x in unique([x[1] for x in keys(pairs_dict)])])
temp = [(x[1], pairs_dict[x]) for x in keys(pairs_dict)]
for (x,v) in temp
    chars_dict[x] += v
end

chars_dict[last(template2)] += 1
occurence2 = sort([chars_dict[x] for x in keys(chars_dict)])
println("Part 2: ", last(occurence2) - first(occurence2))
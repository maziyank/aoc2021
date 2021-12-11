# Day 10 AOC 2021
# maziyank@github.com

input = readlines(open("day10.txt", "r"))
pairs = Dict( '[' => ']', '(' => ')', '{' => '}', '<' => '>' )

# Part 1
score = Dict( ')' => 3, ']' => 57,  '}' => 1197, '>' => 25137, "" => 0)
function find_issues(code)
    expect_next_char = Vector{Char}()
    for char in code
        if char in keys(pairs)
            append!(expect_next_char, pairs[char])
        end
        if char in values(pairs)
           if last(expect_next_char) == char
                deleteat!(expect_next_char, length(expect_next_char))
            else
                return (char, expect_next_char)
            end 
        end
    end
    
    return ("", expect_next_char)
end

problems = [find_issues(code) for code in input]
part1_scores = map(x-> score[x[1]], problems)
println("Part 1: ", sum(part1_scores))

# Part 2
score2 = Dict(')' => 1, ']' => 2,  '}' => 3, '>' => 4)
incomplete = filter(x-> x[1] == "", problems)

part2_scores = []
for (_, completer) in incomplete
    l = length(completer)
    curr_score = 0
    for i in 0:l-1
        curr_score = curr_score * 5 + score2[completer[l-i]]        
    end
    append!(part2_scores, curr_score)
end

sort!(part2_scores)
nscores = length(part2_scores)
midscore = nscores % 2 == 1 ? part2_scores[cld(nscores , 2)] : (part2_scores[cld(nscores, 2)] + part2_scores[fld(nscores, 2)]) 
println("Part 2: ", midscore)
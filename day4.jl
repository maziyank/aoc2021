# Day 4 AOC 2021
# maziyank@github.com

contents = readlines(open("day4.txt", "r"))
numbers = parse.(Int64, split(contents[1], ","))

contents_boards = split.(contents[3:length(contents)])
loc = findall(isempty, contents_boards)
boards = getindex.(Ref(contents_boards), UnitRange.([1; loc .+ 1], [loc .- 1; length(contents_boards)]))
boards = [transpose(parse.(Int, hcat(board...))) for board in boards]

# part 1
function part1(numbers, boards)
    flags = [ones(Int8, size(board)) for board in boards]
    for num in numbers
        for index in 1:length(boards)
            flags[index][findall(x-> x == num, boards[index])] .= 0                
            ncols = count(x -> x == 0, sum(flags[index], dims=2))
            nrows = count(x -> x == 0, sum(flags[index], dims=1))
            if ncols == 1 | nrows == 1            
                return num * sum(boards[index][findall(x-> x==1, flags[index])])
            end
        end            
    end
end

println("Part 1:", part1(numbers, boards))

# part 2
function part2(numbers, boards)
    flags = [ones(Int8, size(board)) for board in boards]
    board_win, num_boards = zeros(Int8,length(boards)), length(boards)
    for num in numbers
        for index in 1:num_boards
            flags[index][findall(x-> x == num, boards[index])] .= 0                
            ncols = count(x -> x == 0, sum(flags[index], dims=2))
            nrows = count(x -> x == 0, sum(flags[index], dims=1))
            
            if (ncols == 1 || nrows == 1)
                board_win[index] = 1                    
            end
            
            if sum(board_win) == num_boards 
                return num * sum(boards[index][findall(x-> x==1, flags[index])])
            end            
            
        end            
    end
end

println("Part 2:", part2(numbers, boards))
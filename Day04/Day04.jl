using StaticArrays

const BINGO_SIZE = 5
const Board = SMatrix{BINGO_SIZE,BINGO_SIZE, Int}
const Hits = MMatrix{BINGO_SIZE,BINGO_SIZE, Bool}

mutable struct Bingo
	board::Board
	hits::Hits
	done::Bool
	Bingo(b) = new(b, falses(BINGO_SIZE,BINGO_SIZE), false)
end

score(b::Bingo, x::Int) = x * sum(b.board[.!b.hits])

function Day04(filename)
	file = open(filename)
	numbers = parse.(Int, split(readline(file)::String, ','))
	readline(file)

	bingos = Vector{Bingo}()
	parse_line() = parse.(Int, split(readline(file)))
	while !eof(file)
		push!(bingos, Bingo(hcat([parse_line() for i ∈ 1:BINGO_SIZE]...)))
		readline(file)
	end
	close(file)

	winner_score = -1
	looser_score = -1
	boards_left = length(bingos)
	for x ∈ numbers, b ∈ bingos
		b.done && continue
		for i ∈ 1:BINGO_SIZE, j ∈ 1:BINGO_SIZE
			if b.board[j,i] == x
				b.hits[j,i] = true
			end
		end
		if any(all(b.hits, dims=1)) || any(all(b.hits, dims=2))
			b.done = true
			if winner_score == -1
				winner_score = score(b, x)
			end
			if boards_left == 1
				looser_score = score(b, x)
				break
			end
			boards_left -= 1
		end
	end
	

	return winner_score, looser_score
end

r1,r2 = Day04("input.txt")
println("Part 1: $r1")
println("Part 2: $r2")

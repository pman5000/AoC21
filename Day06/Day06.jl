const DAYS1 = 80
const DAYS2 = 256

function step(fishin)
	fishout = similar(fishin)
	for i ∈ 2:9
		fishout[i-1] = fishin[i]
	end
	fishout[7] += fishin[1]
	fishout[9] = fishin[1]
	return fishout
end

function run(fish, days)
	for d ∈ 1:days
		fish = step(fish)
	end
	return sum(fish)
end

function Day06(filename)
	input = parse.(Int, split(read(filename, String), ','))
	
	fish = zeros(Int, 9)
	for c ∈ input
		fish[c+1] += 1
	end
	
	return run(fish, DAYS1), run(fish, DAYS2)
end

cd(@__DIR__)
r1,r2 = Day06("input.txt")
println("Part 1 (step): $r1")
println("Part 1 (exp):  $r2")

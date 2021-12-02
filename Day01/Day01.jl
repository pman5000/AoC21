function Part1(input)
	last_value = 0
	count = -1 # don't count first line
	for value in input
		if value > last_value
			count += 1
		end
		last_value = value
	end
	return count
end

function Part2(input)
	last_value = 0
	count = -1 # don't count first line
	for i in 3:lastindex(input)
		#@views value = sum(input[i-2:i]) #slow
		value = input[i-2] + input[i-1] + input[i]
		if  value > last_value
			count += 1
		end
		last_value = value
	end
	return count
end

function Day01(filename)
	input_str = read(filename, String)
	lines = split(input_str, "\n", keepempty=false)
	input = map(line->parse(Int, line), lines)

	println("Part 1: $(Part1(input))")
	println("Part 2: $(Part2(input))")
end

Day01("input.txt")

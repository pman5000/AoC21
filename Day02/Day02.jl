function Day02(filename)
	x = y1 = y2 = aim = 0
	for line in eachline(filename)
		dir, dist = split(line, " ");
		dist = parse(Int, dist)
		if dir == "forward"
			x += dist
			y2 += dist*aim
		elseif dir == "down"
			y1 += dist
			aim += dist
		elseif dir == "up"
			y1 -= dist
			aim -= dist
		else
			throw("unkown direction")
		end
	end
	println("Part 1: $(x*y1)")
	println("Part 2: $(x*y2)")
end

Day02("input.txt")

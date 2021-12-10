using StaticArrays

struct Line <: FieldVector{4, Int}
	x1::Int; y1::Int
	x2::Int; y2::Int
	Line(line::String) = new(parse.(Int, vcat(split.(split(line,"->"),',')...))...)
end

ishorizontal(l::Line) = l.x1 == l.x2
isvertical(l::Line) = l.y1 == l.y2

function Day05(filename)
	lines = Vector{Line}()
	xmax = ymax = 0
	for line_str in eachline(filename)
		line = Line(line_str)
		push!(lines, line)
		xmax < line.x1 && (xmax = line.x1)
		xmax < line.x2 && (xmax = line.x2)
		ymax < line.y1 && (ymax = line.y1)
		ymax < line.y2 && (ymax = line.y2)
	end

	field = zeros(Int, ymax, xmax)
	for line ∈ lines
		if ishorizontal(line)
			field[line.y1, line.x2:line.x1] .+= 1
		elseif isvertical(line)
			field[line.y2:line.y1, line.x1] .+= 1
		end
	end
	r1 = count(x->x≥2, field)

	return r1
end

cd(@__DIR__)
r1 = Day05("input.txt")
println("Part 1: $r1")

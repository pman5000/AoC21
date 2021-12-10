using StaticArrays

struct Line <: FieldVector{4, Int}
	x1::Int; y1::Int
	x2::Int; y2::Int
	Line(line::String) = new(parse.(Int, vcat(split.(split(line,"->"),',')...))...)
end

ishorizontal(l::Line) = l.y1 == l.y2
isvertical(l::Line) = l.x1 == l.x2
isdiagonal(l::Line) = !(isvertical(l) || ishorizontal(l))
mkrange(x1,x2) = x1:(x1<x2 ? 1 : -1):x2
count_overlaps(field) = count(x->x≥2, field)

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
	for l ∈ lines
		if ishorizontal(l)
			field[l.y1, mkrange(l.x1,l.x2)] .+= 1
		elseif isvertical(l)
			field[mkrange(l.y1,l.y2), l.x1] .+= 1
		end
	end
	r1 = count_overlaps(field)

	for l ∈ lines
		if isdiagonal(l)
			for i ∈ zip(mkrange(l.y1,l.y2), mkrange(l.x1,l.x2))
				field[i...] += 1
			end
		end
	end
	r2 = count_overlaps(field)

	return r1,r2
end

cd(@__DIR__)
r1,r2 = Day05("input.txt")
println("Part 1: $r1")
println("Part 2: $r2")

function Day03(filename)
	input = readlines(filename)
	n = length(input[1])
	m = length(input)
	
	function count_most_ones(rows, cols)
		counts = zeros(Int, length(cols))
		for j ∈ rows
			for i ∈ 1:length(cols)
				if input[j][cols[i]] == '1'
					counts[i] += 1
				end
			end
		end
		return [2c ≥ length(rows) for c ∈ counts]
	end

	# Part 1
	most_ones = count_most_ones(1:m, 1:n)
	γ = ϵ = zero(UInt)
	for i ∈ 1:n
		k = 1<<(n-i)
		if most_ones[i]
			γ += k
		else
			ϵ += k
		end
	end
	r1 = γ*ϵ

	# Part 2
	function p2rating(sel)
		cur_list = collect(1:m)
		next_list = Vector{Int}()
		sizehint!(next_list, m)
		result = ""
		for i ∈ 1:n
			crit = count_most_ones(cur_list, [i])[1] == sel ? '1' : '0'
			for j ∈ cur_list
				if input[j][i] == crit
					push!(next_list, j)
				end
			end
			if length(next_list) > 1
				copy!(cur_list, next_list)
				empty!(next_list)
			else
				if length(next_list) == 1
					result = input[next_list[1]]
				else
					result = input[cur_list[end]]
					println("hmm $j $i")
				end
				break
			end
		end
		return parse(Int, result, base=2)
	end
	O2 = p2rating(true)
	CO2 = p2rating(false)
	r2 = O2*CO2

	return r1, r2
end

r1, r2 = Day03("input.txt")
println("Part 1: $r1")
println("Part 2: $r2")

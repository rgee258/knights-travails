class Knight

	def knight_moves(start, finish)

		if (start.nil? || finish.nil?)
			return "Missing start or end coordinates."
		elsif (start[0] < 0 || start[0] > 7 || start[1] < 0 || start[0] > 7)
			return "One of your start coordinate values aren't valid, make sure they're all numbers from 0 to 7."
		elsif (finish[0] < 0 || finish[0] > 7 || finish[1] < 0 || finish[1] > 7)
			return "One of your end coordinate values aren't valid, make sure they're all numbers from 0 to 7."
		end

		if (start == finish)
			return [finish]
		end

		# Create grid
		grid = Array.new(8) {Array.new(8)}
		8.times do |row|
			8.times do |col|
				grid[row][col] = [row, col, false]
			end
		end

		# Create tree
		tree = Tree.new()
		tree.build_tree(grid, start, finish)

		# Search through tree using BFS
		path = []
		queue = [tree.root]
		while(!queue.empty?)
			curr = queue.shift
			# If found, follow the path back to the start coordinates
			if (curr.value == finish)
				found = curr
				while (!found.parent.nil?)
					path.unshift(found.value)
					found = found.parent
				end
				path.unshift(start)
				break
			end
			# Add all of the children to the queue for the current node
			if (!curr.children.empty?)
				curr.children.each do |child|
					queue.push(child)
				end
			end
		end

		return path
	end
end

class Tree

	attr_reader :root

	def initialize
		@root = nil
	end

	def build_tree(grid, start, finish)
		# Add children to each node's children array
		# Continue until all squares are visited
		# Checks are:
		# If they leave the board
		# If they are visited store in the visited array
		visited = []
		@root = Node.new(start)
		curr = @root
		build_queue = [curr]
		while (!build_queue.empty?) do
			curr = build_queue.shift
			visited.push(curr.value)
			# Check moves going up 2
			if (curr.value[1] + 2 < 8)
				# Go left 1
				if (curr.value[0] - 1 > -1 && !visited.include?([curr.value[0] - 1, curr.value[1] + 2]))
					new_child = Node.new([curr.value[0] - 1, curr.value[1] + 2], curr)
					curr.children.push(new_child)
					build_queue.push(new_child)
				end
				# Go right 1
				if (curr.value[0] + 1 < 8 && !visited.include?([curr.value[0] + 1, curr.value[1] + 2]))
					new_child = Node.new([curr.value[0] + 1, curr.value[1] + 2], curr)
					curr.children.push(new_child)
					build_queue.push(new_child)
				end
			end
			# Check moves going right 2
			if (curr.value[0] + 2 < 8)
				# Go up 1
				if (curr.value[1] + 1 < 8 && !visited.include?([curr.value[0] + 2, curr.value[1] + 1]))
					new_child = Node.new([curr.value[0] + 2, curr.value[1] + 1], curr)
					curr.children.push(new_child)
					build_queue.push(new_child)
				end
				# Go down 1
				if (curr.value[1] - 1 > -1 && !visited.include?([curr.value[0] + 2, curr.value[1] - 1]))
					new_child = Node.new([curr.value[0] + 2, curr.value[1] - 1], curr)
					curr.children.push(new_child)
					build_queue.push(new_child)
				end
			end
			# Check moves going down 2
			if (curr.value[1] - 2 > -1)
				# Go left 1
				if (curr.value[0] - 1 > -1 && !visited.include?([curr.value[0] - 1, curr.value[1] - 2]))
					new_child = Node.new([curr.value[0] - 1, curr.value[1] - 2], curr)
					curr.children.push(new_child)
					build_queue.push(new_child)
				end
				# Go right 1
				if (curr.value[0] + 1 < 8 && !visited.include?([curr.value[0] + 1, curr.value[1] - 2]))
					new_child = Node.new([curr.value[0] + 1, curr.value[1] - 2], curr)
					curr.children.push(new_child)
					build_queue.push(new_child)
				end
			end
			# Check moves going left 2
			if (curr.value[0] - 2 > -1)
				# Go up 1
				if (curr.value[1] + 1 < 8 && !visited.include?([curr.value[0] - 2, curr.value[1] + 1]))
					new_child = Node.new([curr.value[0] - 2, curr.value[1] + 1], curr)
					curr.children.push(new_child)
					build_queue.push(new_child)
				end
				# Go down 1
				if (curr.value[1] - 1 > -1 && !visited.include?([curr.value[0] - 2, curr.value[1] - 1]))
					new_child = Node.new([curr.value[0] - 2, curr.value[1] - 1], curr)
					curr.children.push(new_child)
					build_queue.push(new_child)
				end
			end
		end
	end

end

class Node
	attr_accessor :value, :parent, :children

	def initialize(value = nil, parent = nil)
		@value = value
		@parent = parent
		@children = []
	end
end
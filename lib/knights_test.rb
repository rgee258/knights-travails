require "./knights_travails"

sir_codesalot = Knight.new()
puts "Path from [3,1] to [0,7]: #{sir_codesalot.knight_moves([3, 1], [0, 7])}"
puts "Path from [7,7] to [5,2]: #{sir_codesalot.knight_moves([7, 7], [5, 2])}"
puts "Path from [0,0] to [0,0]: #{sir_codesalot.knight_moves([0, 0], [0, 0])}"
puts "Path from [6,1], [2,7]: #{sir_codesalot.knight_moves([6, 1], [2, 7])}"
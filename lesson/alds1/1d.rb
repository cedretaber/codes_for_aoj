n = gets.chomp.to_i
r_min = gets.chomp.to_i
ret = -(1.0/0)

(n-1).times do
  r = gets.chomp.to_i
  ret = [ret, r - r_min].max
  r_min = [r_min, r].min
end

puts ret
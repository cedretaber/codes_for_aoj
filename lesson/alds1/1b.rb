x, y = gets.split.map(&:to_i).sort

until x == 0
  x, y = y % x, x
end

puts y
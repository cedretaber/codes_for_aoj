def isort! a, n
  1.upto(n-1) do |i|
    puts a.map(&:to_s).join(" ")
    v = a[i]
    j = i-1
    while j >= 0 && a[j] > v
      a[j+1] = a[j]
      j -= 1
    end
    a[j+1] = v
  end
end

n = gets.chomp.to_i
a = gets.split.map(&:to_i)

isort!(a, n)
puts a.map(&:to_s).join(" ")
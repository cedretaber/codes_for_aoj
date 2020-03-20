class BinaryIndexTree

  def initialize n, arr = [], init = 0, &block
    block = ->(a, b) { a + b } unless block_given?
    @fun = block

    @n = n
    @init = init

    @tree = Array.new(n+1) { init }
    arr.each.with_index(1) do |e, i|
      put(i, e)
    end
  end

  def put i, e
    while i <= @n
      @tree[i] = @fun.(@tree[i], e)
      i += i & -i
    end
  end

  def query i
    r = @init
    while i > 0
      r = @fun.(r, @tree[i])
      i -= i & -i
    end
    r
  end
end

n = gets.to_i
as = gets.split.map(&:to_i)
cs = as.sort.each.with_index(1).reduce({}) do |h, (a, i)|
  h[a] = i
  h
end

r = 0
bit = BinaryIndexTree.new(n)
as.each.with_index do |a, i|
  j = cs[a]
  r += i - bit.query(j)
  bit.put(j, 1)
end
puts r
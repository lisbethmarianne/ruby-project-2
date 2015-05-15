module Enumerable
  def my_each     #(&block)
    i = 0
    while i < self.length
      yield self[i]
      # block.call(self[i])
      i += 1
    end
    self
  end

  def my_each_with_index
    i = 0
    while i < self.length
      yield self[i], i
      i += 1
    end
    self
  end

  def my_select
    result = []
    self.my_each { |item| result << item if yield item }
    result
  end

  def my_all?
    self == self.my_select { |item| yield item }
  end

  def my_any?
    self.my_select { |item| yield item } != []
  end

  def my_none?
    self.my_select { |item| yield item } == []
  end

  def my_count
    self.my_select { |item| yield item }.length
  end

  def my_map(proc = nil)
    result = []
    if proc && block_given?
      self.my_each { |item| result << proc.call(yield(item)) }
    elsif proc && !block_given?
      self.my_each { |item| result << proc.call(item) }
    elsif proc.nil? && block_given?
      self.my_each { |item| result << yield(item) }
    else
      self
    end
    result
  end

  def my_inject(result = 0)
    i = 0
    while i < self.length
      result = yield result, self[i]
      i += 1
    end
    result
  end
end

# Tests:
p [1,2,3].each { |num| num + 1 }
p [1,2,3].my_each { |num| num + 1 }
[1,2,3].each { |num| p num + 1 }
[1,2,3].my_each { |num| p num + 1 }

p [1,2,3].each_with_index { |num, i| num + i }
p [1,2,3].my_each_with_index { |num, i| num + i }
[1,2,3].each_with_index { |num, i| p num + i }
[1,2,3].my_each_with_index { |num, i| p num + i }

p [1,2,3].select { |num| num < 2 }
p [1,2,3].my_select { |num| num < 2 }

p [1,2,3].all? { |num| num < 2 }
p [1,2,3].my_all? { |num| num < 2 }
p [1,2,3].all? { |num| num < 7 }
p [1,2,3].my_all? { |num| num < 7 }

p [1,2,3].any? { |num| num < 2 }
p [1,2,3].my_any? { |num| num < 2 }
p [1,2,3].any? { |num| num > 7 }
p [1,2,3].my_any? { |num| num > 7 }

p [1,2,3].none? { |num| num > 4 }
p [1,2,3].my_none? { |num| num > 4 }

p [1,2,3].count { |num| num > 2 }
p [1,2,3].my_count { |num| num > 2 }

p [1,2,3].map { |num| num + 1 }
p [1,2,3].my_map { |num| num + 1 }

square = Proc.new do |n|
  n ** 2
end

p [1,2,3].my_map(square) { |num| num + 1 }
p [1,2,3].my_map(square)

p [1,2,3].inject { |value, num| num + value }
p [1,2,3].my_inject { |value, num| num + value } 

def multiply_els(array)
  p array.inject(1) { |product, num| product * num }
end

multiply_els([2,4,5])
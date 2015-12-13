module Enumerable
  def my_each
    for i in self
      yield(i)
    end
    self
  end

  def my_each_with_index
    index = 0
    for i in self
      yield(i)
      index += 1
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
    for i in self
      result = yield result, i
    end
    result
  end
end


def multiply_els(array)
  array.inject(1) { |product, num| product * num }
end

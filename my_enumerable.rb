module Enumerable
  def my_each
    i = 0
    while i < self.length
      yield self[i]
      i += 1
    end
  end

  def my_each_with_index
    i = 0
    while i < self.length
      yield self[i], i
      i += 1
    end
  end

  def my_select
    result = []
    self.my_each { |item| result << item if yield(item) }
    result
  end

  def my_all?
    self == self.my_select { |item| yield(item) }
  end

  def my_any?
    self.my_select { |item| yield(item) } != []
  end

  def my_none?
    self.my_select { |item| yield(item) } == []
  end

  def my_count
    self.my_select { |item| yield(item) }.length
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

require_relative '../my_enumerable'

describe Enumerable do
  describe 'my_each' do
    it 'can be applied to an Array' do
      expect([1,2,3].my_each { |num| num + 1 }).to eql [1,2,3]
    end

    it 'can be applied to a Hash' do
      expect({:a => 1, :b => 2, :c => 3}.my_each { |key, value| value }).to eql({:a=>1, :b=>2, :c=>3})
    end

    it 'returns the given Array' do
      expect([1,2,3].my_each { |num| num + 1 }).to eql [1,2,3]
    end

    it 'returns the given Hash' do
      expect({:a=>1, :b=>2, :c=>3}.my_each { |key, value| value }).to eql({:a=>1, :b=>2, :c=>3})
    end
  end

  describe 'my_each_with_index' do
    it 'returns the given Array' do
      expect([1,2,3].each_with_index { |num, i| num + i }).to eql [1,2,3]
    end
  end

  describe 'my_select' do
    context 'applied to Array' do
      it 'returns Array' do
        expect([1,2,3].select { |num| num < 2 }).to be_a(Array)
      end

      it 'selects all item in an array for which the condition is true' do
        expect([1,2,3].select { |num| num < 2 }).to eql [1]
      end

      context 'nothing is selected' do
        it 'returns empty Array' do
          expect([1,2,3].select { |num| num < 1 }).to eql []
        end
      end
    end
  end

  describe 'my_all' do
    context 'block returns true for all items' do
      it 'returns true' do
        expect([1,2,3].my_all? { |num| num < 5 }).to be true
      end
    end

    context 'block returns false for one or more items' do
      it 'returns false' do
        expect([1,2,3].my_all? { |num| num < 2 }).to be false
      end
    end
  end

  describe 'my_any' do
    context 'block returns true for one or more items' do
      it 'return true' do
        expect([1,2,3].my_any? { |num| num < 2 }).to be true
      end
    end

    context 'block returns false all items' do
      it 'return false' do
        expect([1,2,3].my_any? { |num| num < 1 }).to be false
      end
    end
  end

  describe 'my_none' do
    context 'block returns false for all items' do
      it 'returns true' do
        expect([1,2,3].my_none? { |num| num > 4 }).to be true
      end
    end

    context 'block returns true for one or more items' do
      it 'returns false' do
        expect([1,2,3].my_none? { |num| num > 2 }).to be false
      end
    end
  end

  describe 'my_count' do
    it 'returns number of items for which the block returns true' do
      expect([1,2,3].my_count { |num| num > 2 }).to eql 1
    end
  end

  describe 'my_map' do
    it 'returns a new array with the results from the block' do
      expect([1,2,3].my_map { |num| num + 1 }).to eql [2,3,4]
    end

    it 'takes a proc' do
      square = Proc.new { |n| n ** 2 }
      expect([1,2,3].my_map(square)).to eql [1, 4, 9]
    end

    it 'takes a proc and a block' do
      square = Proc.new { |n| n ** 2 }
      expect([1,2,3].my_map(square) { |num| num + 1 }).to eql [4, 9, 16]
    end
  end

  describe 'my_inject' do
    it 'combines all items by a given operation' do
      expect([1,2,3].my_inject { |value, num| num + value }).to eql 6
      expect([1,2,3].my_inject(1) { |value, num| num * value }).to eql 6
    end
  end
end


describe 'multiply_els' do
  it 'multiplies all the elements of the array together' do
    expect(multiply_els([2,4,5])).to eql 40
  end
end

def bubble_sort(input)
  bubble_sort_by(input) { |a, b| b - a }
end

def bubble_sort_by(input, sorted = false)
  until sorted do 
    sorted = true
    i = 0
    while i < (input.length - 1) do
      if (yield input[i], input[i+1]) < 0    # left is longer -> negative value
        input.insert(i,input[i+1])
        input.delete_at(i+2)
        sorted = false
      end
      i += 1
    end
  end
  p input
end

bubble_sort([4,3,78,2,0,2])
   # => [0,2,2,3,4,78]

bubble_sort_by(["hi","hello","hey"]) { |left, right| right.length - left.length }
   # => ["hi", "hey", "hello"]

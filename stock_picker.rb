def stock_picker(prizes)
  prizes = prizes
  indices = (0..prizes.length - 1).to_a

  couples = prizes.combination(2).to_a
  ix_couples = indices.combination(2).to_a
  
  max = couples.max_by {|pair| pair[1] - pair[0]}
  ix_couples[couples.index(max)]
end

p stock_picker([17,3,6,9,15,8,6,1,10])    # [1,4] => for a profit of $15 - $3 == $12

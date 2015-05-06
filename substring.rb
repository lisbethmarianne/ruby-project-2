def substrings(string, dictionary)
  string_arr = string.downcase.split(" ")
  dict_hash = dictionary.product([0]).to_h

  dictionary.each do |word|
    string_arr.each do |string|
      dict_hash[word] += 1 if string.include?(word)
    end
  end

  dict_hash.reject { |key, value| value == 0}
end



dictionary = ["below","down","go","going","horn","how","howdy","it","i","low","own","part","partner","sit"]

p substrings("below", dictionary)      # => {"below"=>1, "low"=>1}
p substrings("Howdy partner, sit down! How's it going?", dictionary)
    # => {"down"=>1, "how"=>2, "howdy"=>1,"go"=>1, "going"=>1, "it"=>2, "i"=> 3, "own"=>1,"part"=>1,"partner"=>1,"sit"=>1}
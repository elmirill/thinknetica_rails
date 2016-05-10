alphabet = ('a'..'z')
alphabet_hash = {}

alphabet.each_with_index do |l, i| 
  alphabet_hash[l.to_sym] = i + 1
end

vowels = [:a, :e, :i, :o, :u, :y]
vowels_hash = alphabet_hash.select { |k, v| vowels.include? k }

puts alphabet_hash
puts vowels_hash
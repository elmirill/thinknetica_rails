alphabet = ('a'..'z').to_a
alphabet_hash = {}

alphabet.each do |l| 
  alphabet_hash[l.to_sym] = alphabet.index(l) + 1
end

vowels = [:a, :e, :i, :o, :u, :y]
vowels_hash = alphabet_hash.select { |k, v| vowels.include? k }

puts vowels_hash
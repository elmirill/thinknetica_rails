alphabet = ('a'..'z')
vowels_hash = {}
vowels = ['a', 'e', 'i', 'o', 'u', 'y']

alphabet.each_with_index do |l, i| 
  vowels_hash[l.to_sym] = i + 1 if vowels.include? l
end

puts vowels_hash
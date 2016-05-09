fl = [0, 1]

while fl[-1] <= 100 do 
  fl << fl[-2] + fl[-1]
end

fl.pop

puts fl
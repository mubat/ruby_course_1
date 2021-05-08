### Create array of Fibbonachi numbers

fibbonachi = Array.new(100)

fibbonachi.each_index do |i|
  if(i <= 1)
    fibbonachi[i] = i
    next
  end

  fibbonachi[i] = fibbonachi[i-1] + fibbonachi[i-2]

end

# secibd variant
fibbonachi2 = []
100.times do |i|
  if i < 2
    fibbonachi2[i] = i
    next
  end
  fibbonachi2[i] = fibbonachi2[i-1] + fibbonachi2[i-2]

end

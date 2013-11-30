

json = [
    ['a', 'd', 'g', 'j', 'm'],
    ['b', 'e', 'h', 'k', 'n'],
    ['c', 'f', 'i', 'l', 'o']
]


width = json[0].length
width.times do |i|
  json.each do |row|
    puts row[i]
    puts ">><<"
  end
end
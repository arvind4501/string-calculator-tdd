require './lib/string_calculator'

calculator = StringCalculator.new

puts calculator.add('')             # => 0
puts calculator.add('1')            # => 1
puts calculator.add('1,5')          # => 6
puts calculator.add("1\n2,3")       # => 6
puts calculator.add("\n")           # => 6
puts calculator.add("1\n2\n3,4\n5") # => 15
puts calculator.add("//;\n1;2")     # => 3
puts calculator.add("//x\n4x5")     # => 9
puts calculator.add("//,\n1,2,3,4") # => 10

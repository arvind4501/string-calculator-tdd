require './lib/string_calculator'

calculator = StringCalculator.new

puts calculator.add('')            # => 0
puts calculator.add('100')         # => 100
puts calculator.add('1,2,3,4,5,6') # => 21


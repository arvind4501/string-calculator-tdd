require './lib/string_calculator'

calculator = StringCalculator.new

puts calculator.add('')      # => 0
puts calculator.add('100')   # => 100

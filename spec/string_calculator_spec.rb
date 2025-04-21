require 'string_calculator'

RSpec.describe StringCalculator do
  describe '#add' do
    let(:calculator) { StringCalculator.new }

    it 'returns 0 for an empty string' do
      expect(calculator.add('')).to eq(0)
    end

    it 'returns the number for a single number' do
      expect(calculator.add('1')).to eq(1)
    end

    it 'returns the sum for multiple numbers' do
      expect(calculator.add('1,2,3')).to eq(6)
    end

    it 'handles new line separators' do
      expect(calculator.add("1\n2,3")).to eq(6)
    end

    it 'returns 0 for a string with just a newline' do
      expect(calculator.add("\n")).to eq(0)
    end

    it 'returns the sum for numbers with mixed delimiters' do
      expect(calculator.add("1\n2\n3,4\n5")).to eq(15)
    end

    it 'supports custom delimiters' do
      expect(calculator.add("//;\n1;2")).to eq(3)
    end

    it 'supports custom delimiter x' do
      expect(calculator.add("//x\n4x5")).to eq(9)
    end

    it 'supports custom delimiter , (comma)' do
      expect(calculator.add("//,\n1,2,3,4")).to eq(10)
    end

    it 'raises an error for a single negative number' do
      expect { calculator.add("1,-2,3") }.to raise_error(StringCalculator::NegativeNumberError, "negative numbers not allowed: -2")
    end

    it 'raises an error for multiple negative numbers' do
      expect { calculator.add("1,-2,-3,4") }.to raise_error(StringCalculator::NegativeNumberError, "negative numbers not allowed: -2, -3")
    end
  end
end

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
  end
end

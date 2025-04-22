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

    it 'ignores numbers greater than 1000' do
      expect(calculator.add("2,1001")).to eq(2)
    end

    it 'supports custom delimiters of any length' do
      expect(calculator.add("//[***]\n1***2***3")).to eq(6)
    end

    it 'supports custom delimiter with special regex characters' do
      expect(calculator.add("//[.]\n2.3")).to eq(5)
    end

    it 'supports delimiter that contains brackets inside' do
      expect(calculator.add("//[[]]\n1[]2[]3")).to eq(6)
    end

    it 'handles delimiter that looks like a number' do
      expect(calculator.add("//[123]\n11232123")).to eq(3)
    end

    it 'raises error for delimiter missing closing bracket' do
      expect { calculator.add("//[***\n1***2***3") }.to raise_error(StandardError)
    end

    it 'raises error for missing newline after delimiter line' do
      expect { calculator.add("//[***]1***2***3") }.to raise_error(StandardError)
    end

    it 'supports delimiter with multiple special characters' do
      expect(calculator.add("//[*+?.]\n1*+?.2*+?.3")).to eq(6)
    end

    it 'raises error for missing newline after delimiter line' do
      expect { calculator.add("//[***]1***2***3") }.to raise_error(StandardError)
    end

    context "when using multiple delimiters" do
      it "supports multiple delimiters like //[[]][***][%]" do
        expect(calculator.add("//[[]][***][%]\n1[]2***3%4")).to eq(10)
      end

      it "supports multiple delimiters like //[*][%]" do
        expect(calculator.add("//[*][%]\n1*2%3")).to eq(6)
      end

      it "supports multiple delimiters with different characters" do
        expect(calculator.add("//[**][%%]\n1**2%%3")).to eq(6)
      end

      it "handles delimiters with special characters" do
        expect(calculator.add("//[*][%%][#]\n1*2%%3#4")).to eq(10)
      end

      it "works with longer delimiters" do
        expect(calculator.add("//[*][***]\n1*2***3")).to eq(6)
      end

      it "correctly handles multiple delimiters and splits the string" do
        expect(calculator.add("//[*][%][#]\n1*2%3#4")).to eq(10)
      end

      it "correctly processes multiple delimiters with no spaces" do
        expect(calculator.add("//[*][#][%]\n1*2#3%4")).to eq(10)
      end

      it "handles mixed short and long delimiters" do
        expect(calculator.add("//[*][****]\n1*2****3")).to eq(6)
      end

      it "handles multiple delimiters with no numbers" do
        expect(calculator.add("//[*][%]\n")).to eq(0)
      end
    end

    it "supports multiple multi-character delimiters" do
      expect(calculator.add("//[*******][%%][@@]\n1*******2%%3@@4")).to eq(10)
    end
  end
end

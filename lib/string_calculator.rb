require 'byebug'

class StringCalculator
  class NegativeNumberError < StandardError; end

  def add(numbers)
    return 0 if numbers.empty?

    delimiter = /[\n,]/

    if numbers.start_with?("//")
      header, numbers = numbers.split("\n", 2)

      if header.include?("[") && header.scan(/\]/).count < header.scan(/\[/).count
        raise StandardError, "Missing closing bracket in delimiter"
      end

      custom_delims = parse_custom_delimiters(header)

      delimiter = Regexp.union(delimiter, *custom_delims.map { |d| Regexp.new(Regexp.escape(d)) })
    end

    numbers = numbers.split(delimiter)
                     .reject(&:empty?)
                     .map(&:to_i)

    # Handle negative numbers
    negatives = numbers.select { |num| num < 0 }
    raise NegativeNumberError, "negative numbers not allowed: #{negatives.join(', ')}" if negatives.any?

    # Ignore numbers greater than 1000
    numbers = numbers.reject { |num| num > 1000 }

    numbers.sum
  end

  private

  def extract_delimiters(header)
    header.scan(/\[(.*?)\]/).flatten.map do |delimiter|
      # Ensure we handle `[]` correctly, and not just `[` or `]` in nested cases
      delimiter.gsub(/\[|\]/, '')
    end
  end

  def parse_custom_delimiters(header)
    if header.include?("[")
      extract_delimiters(header)
    else
      [header[2..]]
    end
  end
end

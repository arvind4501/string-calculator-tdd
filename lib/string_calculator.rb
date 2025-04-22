require 'byebug'

class StringCalculator
  class NegativeNumberError < StandardError; end

  def add(numbers)
    return 0 if numbers.empty?

    delimiter = /[\n,]/

    if numbers.start_with?("//")
      header, numbers = numbers.split("\n", 2)

      custom_delim = if header.include?("[")
        header[/^\s*\/\/\[(.+)\]\s*$/, 1]
      else
        header[2..]
      end

      delimiter = Regexp.union(delimiter, Regexp.new(Regexp.escape(custom_delim)))
    end

    numbers = numbers
      .split(delimiter)
      .reject(&:empty?)
      .map(&:to_i)

    # Handle negative numbers
    negatives = numbers.select { |num| num < 0 }
    if negatives.any?
      raise NegativeNumberError, "negative numbers not allowed: #{negatives.join(', ')}"
    end

    # Ignore numbers greater than 1000
    numbers = numbers.reject { |num| num > 1000 }

    numbers.sum
  end
end

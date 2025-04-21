require 'byebug'

class StringCalculator
  class NegativeNumberError < StandardError; end

  def add(numbers)
    return 0 if numbers.empty?

    numbers.split(/[\n,]/).map(&:to_i).sum

    delimiter = /[\n,]/

    if numbers.start_with?("//")
      header, numbers = numbers.split("\n", 2)

      custom_delim = header[2..]
      delimiter = Regexp.union(delimiter, Regexp.escape(custom_delim))
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

    numbers.sum
  end
end

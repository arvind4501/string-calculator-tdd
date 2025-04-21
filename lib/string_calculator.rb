require 'byebug'

class StringCalculator
  def add(numbers)
    return 0 if numbers.empty?

    numbers.split(/[\n,]/).map(&:to_i).sum

    delimiter = /[\n,]/

    if numbers.start_with?("//")
      header, numbers = numbers.split("\n", 2)

      custom_delim = header[2..]
      delimiter = Regexp.union(delimiter, Regexp.escape(custom_delim))
    end

    numbers
      .split(delimiter)
      .reject(&:empty?)
      .map(&:to_i)
      .sum
  end
end

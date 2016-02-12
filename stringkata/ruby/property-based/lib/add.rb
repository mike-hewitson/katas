module Add
  def add_string(string)
    if string == ''
      0
    else
      dlm = string[%r{//(.*?)\n}] ? string[2] : /,|\n/
      array = string.split(dlm).map(&:to_i)
      negatives = array.select { |n| n < 0 }
      fail ArgumentError, negatives.map(&:to_s).join if negatives.size > 0
      array.select { |n| n < 1_001 }.inject(:+)
    end
  end
end

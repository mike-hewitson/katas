module Add
  def add_string(string)
    if string == ''
      0
    else
      array = string.split(',')
      array.inject(0) { |sum, i| sum + i.to_i }
    end
  end
end

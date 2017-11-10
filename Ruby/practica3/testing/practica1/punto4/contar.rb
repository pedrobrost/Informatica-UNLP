def contar string, substring
  if !(string.is_a?(String) && substring.is_a?(String))
    raise TypeError
  end
  string.upcase.scan(/(?=#{substring.upcase})/).count
end


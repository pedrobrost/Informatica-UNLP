def expansor string
  checkErrors(string)
  a = string.chars
  a.reduce("") { |res, c| res << c*get_amount(c) }
end

def checkErrors string
  if !string.is_a? String
    raise StandardError, "La entrada no es un string"
  elsif string == ""
    raise StandardError, "El string es vacío"
  elsif !letter?(string)
    raise StandardError, "El formato del string es incorrecto"
  end
end

def get_amount(c)
  c.upcase.ord - 'A'.ord + 1
end

def letter?(lookAhead)
  lookAhead =~ /[[:alpha:]]/
end

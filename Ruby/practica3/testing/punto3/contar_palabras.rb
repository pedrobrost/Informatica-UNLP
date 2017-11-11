def contar_palabras universe, target
  if !(universe.is_a?(String) && target.is_a?(String))
    raise TypeError
  end
  universe.scan(/\b#{target}\b/i).size
end

def ordenar_arreglo array
  raise TypeError if !array.is_a? Array
  array.sort
end

def en_palabras(time)
  case time.min
    when 0..10
      "Son las #{time.hour} en punto"
    when 11..20
      "Son las #{time.hour} y cuarto"
    when 21..34
      "Son las #{time.hour} y media"
    when 35..44
      "Son las #{time.hour + 1} menos veinticinco"
    when 45..55 
      "Son las #{time.hour + 1} menos cuarto"
    else
      "Son casi las #{time.hour + 1}"
  end
end

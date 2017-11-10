def longitud *args
  args.each { |arg| puts "\"#{arg.to_s}\" --> #{arg.to_s.length}" }
end


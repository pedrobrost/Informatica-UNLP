require 'method_counter'
class MiClase
  include MethodCounter::Countable
  def hola
    puts "Hola"
  end
  def chau
    puts "Chau"
  end
  count_invocations_of :hola, :chau
end

clase = MiClase.new

puts clase.invoked? :hola
puts clase.invoked :hola

clase.hola
clase.hola

puts clase.invoked? :hola
puts clase.invoked :hola

puts clase.invoked :chau

require 'minitest/autorun'
require 'minitest/spec'

require_relative 'ordenar_arreglo.rb'

describe '#ordenar_arreglo' do
  describe 'cuando el parametro es un arreglo' do
    it 'devuelvo un arreglo ordenado' do
      ordenar_arreglo([1, 4, 6, 2, 3, 0, 10]).must_equal [0, 1, 2, 3, 4, 6, 10]
    end

    it 'devuelvo un arreglo ordenado' do
      ordenar_arreglo([]).must_equal []
    end
  end

  describe 'cuando el parametro no es un arreglo' do
    it 'debe levantar una excepcion TypeError' do
      lambda { ordenar_arreglo("hola") }.must_raise TypeError
    end
  end
end


require 'minitest/autorun'
require 'minitest/spec'

require_relative 'ordenar.rb'

describe '#ordenar' do
  it 'devuelvo un arreglo ordenado' do
    ordenar(1, 4, 6, 2, 3, 0, 10).must_equal [0, 1, 2, 3, 4, 6, 10]
  end
end


require 'minitest/autorun'
require 'minitest/spec'

require_relative 'contar.rb'

describe '#contar' do

  describe 'cuando los parámetros no son strings' do
    it 'debe levantar excepción TypeError' do
      lambda {contar(4,'hola')}.must_raise TypeError
    end
    
    it 'debe levantar excepción TypeError' do
      lambda {contar('hola',4)}.must_raise TypeError
    end
  end

  describe 'cuando los parametros son strings' do
    it 'debe retornar la cantidad' do
      contar("hola esto es un texto de prueba", "to").must_equal 2
    end

    it 'debe retornar la cantidad' do
      contar("tohola estoOTO es un texto de pruebaTO", "to").must_equal 5
    end

    it 'debe retornar la cantidad' do
      contar("tohola estoOTO es un texto de pruebaTO", "tosas").must_equal 0
    end

    it 'debe retornar un numero' do
      contar("hola esto es un texto de prueba", "to").must_be_instance_of Integer
    end

    describe 'cuando algun string es vacio' do
      it 'debe retornar 0' do
        contar("", "hola").must_equal 0
      end
    end
  end

end

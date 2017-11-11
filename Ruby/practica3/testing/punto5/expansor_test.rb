require 'minitest/autorun'
require 'minitest/spec'

require_relative 'expansor.rb'

describe 'expansor' do
  # Casos de prueba con situaciones y/o entradas de datos esperadas
  describe 'Casos felices' do
    describe 'cuando la entrada es el string "a"' do
      it 'debe devolver "a"' do
        expansor("a").must_equal "a"
      end
    end
    describe 'cuando la entrada es el string "f"' do
      it 'debe devolver "ffffff"' do
        expansor("f").must_equal "ffffff"
      end
    end
    describe 'cuando la entrada es el string "escoba"' do
      it 'debe devolver "eeeeessssssssssssssssssscccooooooooooooooobba"' do
        expansor("escoba").must_equal "eeeeessssssssssssssssssscccooooooooooooooobba"
      end
    end
  end

  # Casos de pruebas sobre situaciones inesperadas y/o entradas de datos anómalas
  describe 'Casos tristes' do
    describe 'cuando la entrada no es un string' do
      it 'debe disparar una excepción estándar con el mensaje "La entrada no es un string"' do
        err = lambda {expansor(123)}.must_raise StandardError
        err.message.must_match "La entrada no es un string"
      end
    end

    describe 'cuando la entrada es el string vacío' do
      it 'debe disparar una excepción estándar con el mensaje "El string es vacío"' do
        err = lambda {expansor("")}.must_raise StandardError
        err.message.must_match "El string es vacío"
      end
    end

    describe 'cuando la entrada es el string "9"' do
      it 'debe disparar un excepción estándar con el mensaje "El formato del string es incorrecto"' do
        err = lambda {expansor("9")}.must_raise StandardError
        err.message.must_match "El formato del string es incorrecto"
      end
    end

    describe 'cuando la entrada es el string "*"' do
      it 'debe disparar una excepción estándar con el mensaje "El formato del string es incorrecto"' do
        err = lambda {expansor("*")}.must_raise StandardError
        err.message.must_match "El formato del string es incorrecto"
      end
    end
  end
end


require 'minitest/autorun'
require 'minitest/spec'

require_relative 'en_palabras.rb'

describe '#en_palabras' do

  describe 'cuando son y 00' do
    it 'debe indicar en punto' do
      en_palabras(Time.new(2017, 10, 10, 8, 0, 12)).must_equal 'Son las 8 en punto'
    end
  end

  describe 'cuando son y 5' do
    it 'debe indicar en punto' do
      en_palabras(Time.new(2015, 12, 11, 5, 5, 12)).must_equal 'Son las 5 en punto'
    end
  end

  describe 'cuando son y 10' do
    it 'debe indicar en punto' do
      en_palabras(Time.new(2015, 12, 11, 5, 10, 12)).must_equal 'Son las 5 en punto'
    end
  end

  describe 'cuando son y 11' do
    it 'debe indicar y cuarto' do
      en_palabras(Time.new(2015, 12, 11, 5, 11, 12)).must_equal 'Son las 5 y cuarto'
    end
  end

  describe 'cuando son y 15' do
    it 'debe indicar y cuarto' do
      en_palabras(Time.new(2015, 12, 11, 5, 15, 12)).must_equal 'Son las 5 y cuarto'
    end
  end

  describe 'cuando son y 20' do
    it 'debe indicar y cuarto' do
      en_palabras(Time.new(2015, 12, 11, 5, 20, 12)).must_equal 'Son las 5 y cuarto'
    end
  end

  describe 'cuando son y 21' do
    it 'debe indicar y cuarto' do
      en_palabras(Time.new(2015, 12, 11, 5, 21, 12)).must_equal 'Son las 5 y media'
    end
  end

  describe 'cuando son y 30' do
    it 'debe indicar y cuarto' do
      en_palabras(Time.new(2015, 12, 11, 5, 30, 12)).must_equal 'Son las 5 y media'
    end
  end

  describe 'cuando son y 34' do
    it 'debe indicar y cuarto' do
      en_palabras(Time.new(2015, 12, 11, 5, 34, 12)).must_equal 'Son las 5 y media'
    end
  end

  describe 'cuando son y 35' do
    it 'debe indicar y cuarto' do
      en_palabras(Time.new(2015, 12, 11, 5, 35, 12)).must_equal 'Son las 6 menos veinticinco'
    end
  end

  describe 'cuando son y 40' do
    it 'debe indicar y cuarto' do
      en_palabras(Time.new(2015, 12, 11, 5, 40, 12)).must_equal 'Son las 6 menos veinticinco'
    end
  end

  describe 'cuando son y 44' do
    it 'debe indicar y cuarto' do
      en_palabras(Time.new(2015, 12, 11, 5, 44, 12)).must_equal 'Son las 6 menos veinticinco'
    end
  end

  describe 'cuando son y 45' do
    it 'debe indicar y cuarto' do
      en_palabras(Time.new(2015, 12, 11, 5, 45, 12)).must_equal 'Son las 6 menos cuarto'
    end
  end

  describe 'cuando son y 50' do
    it 'debe indicar y cuarto' do
      en_palabras(Time.new(2015, 12, 11, 5, 50, 12)).must_equal 'Son las 6 menos cuarto'
    end
  end

  describe 'cuando son y 55' do
    it 'debe indicar y cuarto' do
      en_palabras(Time.new(2015, 12, 11, 5, 55, 12)).must_equal 'Son las 6 menos cuarto'
    end
  end

  describe 'cuando son y 56' do
    it 'debe indicar y cuarto' do
      en_palabras(Time.new(2015, 12, 11, 5, 56, 12)).must_equal 'Son casi las 6'
    end
  end

  describe 'cuando son y 57' do
    it 'debe indicar y cuarto' do
      en_palabras(Time.new(2015, 12, 11, 5, 57, 12)).must_equal 'Son casi las 6'
    end
  end

  describe 'cuando son y 59' do
    it 'debe indicar y cuarto' do
      en_palabras(Time.new(2015, 12, 11, 5, 59, 12)).must_equal 'Son casi las 6'
    end
  end

end

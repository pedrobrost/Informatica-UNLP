require 'minitest/autorun'
require 'minitest/spec'

require_relative 'countable.rb'

describe Countable do
  describe 'cuando se prueba en una clase nueva' do

    class Prueba
      include Countable
      def uno
      end
    end

    Prueba.count_invocations_of :uno

    before do
      @p = Prueba.new
    end
    
    describe '#invoked?' do
      describe 'cuando nunca se envió el mensaje' do
        it 'debe indicar false' do
          @p.invoked?(:uno).must_equal false
        end
      end

      describe 'cuando se envio el mensaje' do
        it 'debe indicar true' do
          @p.uno
          @p.invoked?(:uno).must_equal true
        end
      end
    end

    describe '#invoked' do
      describe 'cuando nunca se envio el mensaje' do
        it 'debe indicar 0' do
          @p.invoked(:uno).must_equal 0
        end
      end

      describe 'cuando se envio el mensaje' do
        it 'debe indicar 1' do
          @p.uno
          @p.invoked(:uno).must_equal 1
        end

        it 'debe indicar 4' do
          @p.uno
          @p.uno
          @p.uno
          @p.uno
          @p.invoked(:uno).must_equal 4
        end
      end
    end
  end
end


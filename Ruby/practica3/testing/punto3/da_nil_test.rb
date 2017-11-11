require 'minitest/autorun'
require 'minitest/spec'

require_relative 'da_nil.rb'

describe '#da_nil?' do
  describe 'when block given' do
    it 'must return expected value' do
      da_nil? { puts "hola" }.must_equal true
    end

    it 'must return expected value' do
      da_nil? { 2 }.must_equal false
    end
  end

  describe 'when block is not given' do
    it 'must raise LocalJumpError' do
      lambda { da_nil? }.must_raise LocalJumpError
    end
  end
end

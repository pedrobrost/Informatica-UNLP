require 'minitest/autorun'
require 'minitest/spec'

require_relative 'opposite.rb'

describe 'Opposite' do
  describe 'when applied in true' do
    it 'must return false' do
      true.opposite.must_equal false
    end
  end

  describe 'when applied in false' do
    it 'must return true' do
      false.opposite.must_equal true
    end
  end
end

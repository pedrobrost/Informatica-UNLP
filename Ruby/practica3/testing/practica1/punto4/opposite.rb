module Opposite
  def opposite
    !self
  end
end

TrueClass.include Opposite
FalseClass.include Opposite

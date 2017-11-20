module MethodCounter
  module Countable
    def invocations
      @invocations ||= Hash.new(0)
    end

    module ClassMethods
      def count_invocations_of(*syms)
        syms.each do |sym| 
          alias_method(":original_#{sym}", sym) 

          define_method "#{sym}" do
            invocations[__method__] += 1
            send(":original_#{sym}")
          end
        end
      end
    end

    def invoked?(sym)
      invocations[sym] > 0
    end

    def invoked(sym)
      invocations[sym]
    end

    def self.included(base)
      base.extend ClassMethods
    end
  end
end

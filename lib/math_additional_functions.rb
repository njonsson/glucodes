# Defines Glucodes::AdditionalFunctions and mixes it into Math.

# Contains application-specific library extensions.
module Glucodes
  
  # Extends Math with the methods of ClassMethods when AdditionalFunctions is
  # included in Math.
  module AdditionalFunctions
    
    # Defines additional mathematical functions for Math.
    module ClassMethods
      
      # Returns the arithmetic mean of _numbers_.
      def mean(*numbers)
        sum(*numbers) / numbers.length.to_f
      end
      
      # Returns the standard deviation of the population of _numbers_.
      def stddevp(*numbers)
        mean = self.mean(*numbers)
        squared_deviations = numbers.collect do |n|
          (n - mean) ** 2
        end
        sqrt mean(*squared_deviations)
      end
      
      # Returns the sum of _numbers_.
      def sum(*numbers)
        numbers.inject 0 do |result, n|
          result + n
        end
      end
      
    end
    
    def self.included(other_module) #:nodoc:
      other_module.extend ClassMethods
    end
    
  end
  
end

Math.module_eval do
  include Glucodes::AdditionalFunctions #:nodoc:
end

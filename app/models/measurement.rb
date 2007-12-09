class Measurement < ActiveRecord::Base
  
  validates_presence_of :at, :value
  
end

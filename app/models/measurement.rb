# == Schema Information
# Schema version: 1
#
# Table name: measurements
#
#  id            :integer         not null, primary key
#  at            :datetime        not null
#  adjusted_date :date            
#  time_period   :string(1)       
#  value         :integer         not null
#  created_at    :datetime        
#  updated_at    :datetime        
#

class Measurement < ActiveRecord::Base
  
  validates_presence_of :at, :value
  
  before_save :set_time_attributes
  
private
  
  def set_time_attributes
    if adjusted_date.blank?
      self.adjusted_date = (self.at.hour < 2) ? self.at.yesterday : self.at
    end
    if time_period.blank?
      self.time_period = case self.at.hour
                           when [2...6]:   'a'
                           when [6...10]:  'b'
                           when [10...14]: 'c'
                           when [14...18]: 'd'
                           when [18...22]: 'e'
                           else            'f'
                         end
    end
  end
  
end

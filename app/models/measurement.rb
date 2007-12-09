class Measurement < ActiveRecord::Base
  
  validates_presence_of :at, :value
  
  before_save :set_accounting_attributes
  
private
  
  def set_accounting_attributes
    if accounting_date.blank?
      self.accounting_date = (self.at.hour < 2) ? self.at.yesterday : self.at
    end
    if accounting_time_period.blank?
      self.accounting_time_period = case self.at.hour
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

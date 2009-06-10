# == Schema Information
# Schema version: 1
#
# Table name: measurements
#
#  id               :integer         not null, primary key
#  at               :datetime        not null
#  approximate_time :boolean         not null
#  adjusted_date    :date            not null
#  time_period      :string(1)       not null
#  value            :integer         not null
#  notes            :string(255)     
#  created_at       :datetime        
#  updated_at       :datetime        
#

class Measurement < ActiveRecord::Base
  
  attr_accessible :at, :value
  
  validates_presence_of :at, :value
  validates_uniqueness_of :at, :allow_nil => true
  validates_length_of :time_period, :maximum => 1, :allow_nil => true
  validates_numericality_of :value, :only_integer => true,
                                    :greater_than => 0,
                                    :allow_nil => true
  validates_length_of :notes, :maximum => 255, :allow_nil => true
  
  before_save :set_adjusted_date_and_time_period
  
private
  
  def set_adjusted_date_and_time_period
    case self.at.hour
      when (0...5)
        self.time_period = 'g'
        self.adjusted_date = at.yesterday
      when (5...8)
        self.time_period = 'a'
        self.adjusted_date = at
      when (8...11)
        self.time_period = 'b'
        self.adjusted_date = at
      when (11...14)
        self.time_period = 'c'
        self.adjusted_date = at
      when (14...17)
        self.time_period = 'd'
        self.adjusted_date = at
      when (17...20)
        self.time_period = 'e'
        self.adjusted_date = at
      when (20...23)
        self.time_period = 'f'
        self.adjusted_date = at
      else
        self.time_period = 'g'
        self.adjusted_date = at
    end
  end
  
end

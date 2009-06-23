# Defines Measurement.

# Represents an individual glucose measurement.
class Measurement < ActiveRecord::Base
  
  attr_accessible :at, :value, :approximate_time, :notes
  
  validates_presence_of :at, :value
  validates_uniqueness_of :at, :allow_blank => true
  validates_numericality_of :value, :greater_than => 0, :allow_blank => true
  validates_length_of :notes, :maximum => 255, :allow_blank => true
  
  before_save :set_adjusted_dates_and_time_period_and_skew
  
  default_scope :order => 'at DESC'
  
  def severity
    rounded_skew = skew.round(2)
    return nil       if (rounded_skew < 0.20)
    return :moderate if ((0.20 <= rounded_skew) && (rounded_skew <= 0.40))
    :critical
  end
  
private
  
  def set_adjusted_dates_and_time_period_and_skew
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
    self.adjusted_end_of_quarter_date = adjusted_date.end_of_quarter
    self.skew = 1.0 - ((value / 100.0) ** ((value <= 100.0) ? 1.0 : -1.0));
  end
  
end

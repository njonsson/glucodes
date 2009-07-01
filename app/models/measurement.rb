# Defines Measurement.

# Represents an individual glucose measurement.
class Measurement < ActiveRecord::Base
  
  attr_accessible :at, :approximate_time, :value, :notes
  
  validates_presence_of :at, :value
  validates_uniqueness_of :at, :allow_blank => true
  validates_numericality_of :value, :greater_than => 0, :allow_blank => true
  validates_length_of :notes, :maximum => 255, :allow_blank => true
  
  before_save :set_adjusted_date_and_time_slot_and_skew
  
  after_save :recreate_daily_aggregate
  
  default_scope :order => 'at DESC'
  
  def severity
    Severity.of_skew skew
  end
  
private
  
  def recreate_daily_aggregate
    Daily.delete_all({:period_ends_on => adjusted_date})
    days_measurements = Measurement.find(:all,
                                         :conditions => {:adjusted_date => adjusted_date},
                                         :order => 'at')
    values = days_measurements.collect(&:value)
    Daily.create! :period_ends_on => adjusted_date,
                  :contains_approximate_times => days_measurements.any?(&:approximate_time?),
                  :average_value => Math.mean(*values),
                  :standard_deviation_of_value => Math.stddevp(*values),
                  :maximum_value => values.max,
                  :minimum_value => values.min,
                  :average_skew => Measurement.average(:skew, :conditions => {:adjusted_date => adjusted_date}),
                  :average_value_in_time_slot_a => Measurement.average(:value, :conditions => {:adjusted_date => adjusted_date, :time_slot => 'a'}),
                  :average_value_in_time_slot_b => Measurement.average(:value, :conditions => {:adjusted_date => adjusted_date, :time_slot => 'b'}),
                  :average_value_in_time_slot_c => Measurement.average(:value, :conditions => {:adjusted_date => adjusted_date, :time_slot => 'c'}),
                  :average_value_in_time_slot_d => Measurement.average(:value, :conditions => {:adjusted_date => adjusted_date, :time_slot => 'd'}),
                  :average_value_in_time_slot_e => Measurement.average(:value, :conditions => {:adjusted_date => adjusted_date, :time_slot => 'e'}),
                  :average_value_in_time_slot_f => Measurement.average(:value, :conditions => {:adjusted_date => adjusted_date, :time_slot => 'f'}),
                  :average_skew_in_time_slot_a => Measurement.average(:skew, :conditions => {:adjusted_date => adjusted_date, :time_slot => 'a'}),
                  :average_skew_in_time_slot_b => Measurement.average(:skew, :conditions => {:adjusted_date => adjusted_date, :time_slot => 'b'}),
                  :average_skew_in_time_slot_c => Measurement.average(:skew, :conditions => {:adjusted_date => adjusted_date, :time_slot => 'c'}),
                  :average_skew_in_time_slot_d => Measurement.average(:skew, :conditions => {:adjusted_date => adjusted_date, :time_slot => 'd'}),
                  :average_skew_in_time_slot_e => Measurement.average(:skew, :conditions => {:adjusted_date => adjusted_date, :time_slot => 'e'}),
                  :average_skew_in_time_slot_f => Measurement.average(:skew, :conditions => {:adjusted_date => adjusted_date, :time_slot => 'f'}),
                  :notes => days_measurements.collect(&:notes).compact.join("\n\n")
  end
  
  def set_adjusted_date_and_time_slot_and_skew
    case self.at.hour
      when (0...5)
        self.time_slot = 'g'
        self.adjusted_date = at.yesterday.to_date
      when (5...8)
        self.time_slot = 'a'
        self.adjusted_date = at.to_date
      when (8...11)
        self.time_slot = 'b'
        self.adjusted_date = at.to_date
      when (11...14)
        self.time_slot = 'c'
        self.adjusted_date = at.to_date
      when (14...17)
        self.time_slot = 'd'
        self.adjusted_date = at.to_date
      when (17...20)
        self.time_slot = 'e'
        self.adjusted_date = at.to_date
      when (20...23)
        self.time_slot = 'f'
        self.adjusted_date = at.to_date
      else
        self.time_slot = 'g'
        self.adjusted_date = at.to_date
    end
    self.skew = 1.0 - ((value / 100.0) ** ((value <= 100.0) ? 1.0 : -1.0));
  end
  
end

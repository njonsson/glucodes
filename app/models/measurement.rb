# Defines Measurement.

# Represents an individual glucose measurement.
class Measurement < ActiveRecord::Base
  
  class << self
    
    # Returns the default page size for Daily.paginate results.
    def per_page
      25
    end
    
    # Returns the calculated "skew" of the specified glucose _value_. This number
    # between 0.0 and 1.0 represents how far from the ideal _value_ is, either
    # high or low. A higher skew indicates higher risk.
    def skew_of(value)
      1.0 - ((value / 100.0) ** ((value <= 100.0) ? 1.0 : -1.0))
    end
    
  end
  
  attr_accessible :at, :approximate_time, :value, :notes
  
  validates_presence_of :at, :value
  validates_uniqueness_of :at, :allow_blank => true
  validates_numericality_of :value, :greater_than => 0, :allow_blank => true
  validates_length_of :notes, :maximum => 255, :allow_blank => true
  
  before_save :set_adjusted_date_and_time_slot, :set_skew
  
  after_save :recreate_daily_aggregate
  
  default_scope :order => 'at DESC'
  
  # Returns <tt>:critical</tt>, <tt>:moderate</tt> or +nil+ according to the
  # severity of Measurement#skew.
  def severity
    Severity.of_skew skew
  end
  
private
  
  def calculate_average(attribute, adjusted_date, time_slot)
    Measurement.average attribute,
                        :conditions => {:adjusted_date => adjusted_date,
                                        :time_slot => time_slot}
  end
  
  def recreate_daily_aggregate
    Daily.delete_all({:period_ends_on => adjusted_date})
    days_measurements = Measurement.find(:all,
                                         :conditions => {:adjusted_date => adjusted_date},
                                         :order => 'at')
    values = days_measurements.collect(&:value)
    all_notes = days_measurements.collect(&:notes).compact
    if all_notes.empty?
      all_notes = nil
    else
      all_notes = all_notes.join("\n\n")
    end
    averages_attributes = Aggregate::TIME_SLOTS.inject(HashWithIndifferentAccess.new) do |result,
                                                                                          time_slot|
      result["average_value_in_time_slot_#{time_slot}"] = calculate_average(:value, adjusted_date, time_slot)
      result["average_skew_in_time_slot_#{time_slot}"]  = calculate_average(:skew,  adjusted_date, time_slot)
      result
    end
    Daily.create! averages_attributes.merge(:period_ends_on => adjusted_date,
                                            :contains_approximate_times => days_measurements.any?(&:approximate_time?),
                                            :average_value => Math.mean(*values),
                                            :standard_deviation_of_value => Math.stddevp(*values),
                                            :maximum_value => values.max,
                                            :minimum_value => values.min,
                                            :average_skew => Measurement.average(:skew, :conditions => {:adjusted_date => adjusted_date}),
                                            :notes => all_notes)
  end
  
  def set_adjusted_date_and_time_slot
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
    self
  end
  
  def set_skew
    self.skew = Measurement.skew_of(value)
    self
  end
  
end

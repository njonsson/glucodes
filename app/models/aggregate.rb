# Defines Aggregate.

# Represents a set of aggregate Measurement statistics.
class Aggregate < ActiveRecord::Base
  
  TIME_SLOTS = %w(a b c d e f) #:nodoc:
  
  abstract_class = true
  
  attr_protected :id, :type, :created_at, :updated_at
  
  validates_presence_of :period_ends_on, :average_value,
                        :standard_deviation_of_value, :maximum_value,
                        :minimum_value, :average_skew
  validates_uniqueness_of :period_ends_on, :scope => :type, :allow_blank => true
  validates_numericality_of :average_value,
                            :greater_than => 0,
                            :allow_blank => true
  validates_numericality_of :standard_deviation_of_value,
                            :greater_than_or_equal_to => 0,
                            :allow_blank => true
  validates_numericality_of :maximum_value,
                            :greater_than => 0,
                            :allow_blank => true
  validates_numericality_of :minimum_value,
                            :greater_than => 0,
                            :allow_blank => true
  validates_numericality_of :average_skew,
                            :greater_than_or_equal_to => 0,
                            :allow_blank => true
  TIME_SLOTS.each do |time_slot|
    validates_numericality_of "average_value_in_time_slot_#{time_slot}",
                              :greater_than => 0,
                              :allow_blank => true
    validates_numericality_of "average_skew_in_time_slot_#{time_slot}",
                              :greater_than_or_equal_to => 0,
                              :allow_blank => true
  end
  validates_length_of :notes, :maximum => 255, :allow_blank => true
  
  default_scope :order => 'type, period_ends_on DESC'
  
  # Returns <tt>:critical</tt>, <tt>:moderate</tt> or +nil+ according to the
  # severity of Aggregate#average_skew.
  def average_skew_severity
    Severity.of_skew average_skew
  end
  
  # Returns <tt>:critical</tt>, <tt>:moderate</tt> or +nil+ according to the
  # severity of Aggregate#maximum_value.
  def maximum_value_severity
    Severity.of_skew Measurement.skew_of(maximum_value)
  end
  
  # Returns <tt>:critical</tt>, <tt>:moderate</tt> or +nil+ according to the
  # severity of Aggregate#minimum_value.
  def minimum_value_severity
    Severity.of_skew Measurement.skew_of(minimum_value)
  end
  
  # Returns the number of measurements in the
  # <i>average_value_in_time_slot_*</i> attributes.
  def measured_time_slots_count
    TIME_SLOTS.inject([]) do |result, time_slot|
      result + [send("average_value_in_time_slot_#{time_slot}")]
    end.compact.length
  end
  
  # Returns <tt>:critical</tt>, <tt>:moderate</tt> or +nil+ according to the
  # severity of Aggregate#measured_time_slots_count.
  def measured_time_slots_count_severity
    Severity.of_measured_time_slots_count measured_time_slots_count
  end
  
  # Returns the calculated "risk skew" of an Aggregate. This number greater than
  # or equal to 0.0 represents how far from the ideal the Aggregate is. A number
  # indicates higher risk.
  def risk_index
    [(((weighted_average_skew * 15.0) + (5.0 - measured_time_slots_count)) /
      3.0),
     0].max
  end
  
  # Returns a letter grade associated with Aggregate#risk_index. The grade is
  # between "A+" and "F", depending on how far that number is from 0.0.
  def risk_grade
    rounded_risk_index = risk_index.round(6)
    return 'A+' if (rounded_risk_index < 0.333333)
    return 'A'  if (rounded_risk_index < 0.666667)
    return 'A-' if (rounded_risk_index < 1.0)
    return 'B+' if (rounded_risk_index < 1.333333)
    return 'B'  if (rounded_risk_index < 1.666667)
    return 'B-' if (rounded_risk_index < 2.0)
    return 'C+' if (rounded_risk_index < 2.333333)
    return 'C'  if (rounded_risk_index < 2.666667)
    return 'C-' if (rounded_risk_index < 3.0)
    return 'D+' if (rounded_risk_index < 3.333333)
    return 'D'  if (rounded_risk_index < 3.666667)
    return 'D-' if (rounded_risk_index < 4.0)
    'F'
  end
  
  # Returns <tt>:critical</tt>, <tt>:moderate</tt> or +nil+ according to the
  # severity of Aggregate#risk_index.
  def risk_severity
    Severity.of_risk_index risk_index
  end
  
  TIME_SLOTS.each do |time_slot|
    define_method "severity_of_average_skew_in_time_slot_#{time_slot}" do
      skew = send("average_skew_in_time_slot_#{time_slot}")
      return nil unless skew
      Severity.of_skew skew
    end
  end
  
  # Returns the arithmetic mean of the <i>average_value_in_time_slot_*</i>
  # attributes.
  def weighted_average_skew
    skews = TIME_SLOTS.collect do |time_slot|
      send "average_skew_in_time_slot_#{time_slot}"
    end.compact
    Math.mean *skews
  end
  
  # Returns <tt>:critical</tt>, <tt>:moderate</tt> or +nil+ according to the
  # severity of Aggregate#weighted_average_skew.
  def weighted_average_skew_severity
    Severity.of_skew weighted_average_skew
  end
  
end

# Defines Aggregate.

# Represents a set of aggregate Measurement statistics.
class Aggregate < ActiveRecord::Base
  
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
  %w(a b c d e f).each do |time_slot|
    validates_numericality_of :"average_value_in_time_slot_#{time_slot}",
                              :greater_than => 0,
                              :allow_blank => true
    validates_numericality_of :"average_skew_in_time_slot_#{time_slot}",
                              :greater_than_or_equal_to => 0,
                              :allow_blank => true
  end
  validates_length_of :notes, :maximum => 255, :allow_blank => true
  
  default_scope :order => 'type, period_ends_on DESC'
  
  def measured_slots_count
    %w(a b c d e f).inject([]) do |result, time_slot|
      result + [send(:"average_value_in_time_slot_#{time_slot}")]
    end.compact.length
  end
  
  def measured_slots_count_severity
    Severity.of_measured_slots_count measured_slots_count
  end
  
  def risk_index
    [(((weighted_average_skew * 15.0) + (5.0 - measured_slots_count)) / 3.0),
     0].max
  end
  
  def risk_grade
    rounded_risk_index = risk_index.round(8)
    return 'A+' if (rounded_risk_index < 0.33333333)
    return 'A'  if (rounded_risk_index < 0.66666667)
    return 'A-' if (rounded_risk_index < 1.0)
    return 'B+' if (rounded_risk_index < 1.33333333)
    return 'B'  if (rounded_risk_index < 1.66666667)
    return 'B-' if (rounded_risk_index < 2.0)
    return 'C+' if (rounded_risk_index < 2.33333333)
    return 'C'  if (rounded_risk_index < 2.66666667)
    return 'C-' if (rounded_risk_index < 3.0)
    return 'D+' if (rounded_risk_index < 3.33333333)
    return 'D'  if (rounded_risk_index < 3.66666667)
    return 'D-' if (rounded_risk_index < 4.0)
    'F'
  end
  
  def risk_severity
    Severity.of_risk_index risk_index
  end
  
  def weighted_average_skew
    skews = %w(a b c d e f).collect do |time_slot|
      send :"average_skew_in_time_slot_#{time_slot}"
    end.compact
    Math.mean *skews
  end
  
  def weighted_average_skew_severity
    Severity.of_skew weighted_average_skew
  end
  
end

# Defines Aggregate.

# Represents a set of aggregate Measurement statistics.
class Aggregate < ActiveRecord::Base
  
  abstract_class = true
  
  def measured_slots_count; end
  
#  def measured_slots_count_severity
#    red > 3
#    yellow: 3.5
#  end
  
  def risk_index; end
  
  def risk_grade; end
  
#  def risk_severity
#    severe > 2
#    moderate: 1
#  end
  
  def weighted_average_skew; end
  
end

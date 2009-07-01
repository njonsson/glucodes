# Defines Severity.

# Contains methods for calculating severity from various measures.
module Severity
  
  class << self
    
    # Returns <tt>:critical</tt>, <tt>:moderate</tt> or +nil+ according to the
    # severity of _measured_slots_count_.
    def of_measured_slots_count(measured_slots_count)
      rounded_measured_slots_count = measured_slots_count.to_f.round(8)
      return nil       if (rounded_measured_slots_count > 4.0)
      return :moderate if (rounded_measured_slots_count >= 3.5)
      :critical
    end
    
    # Returns <tt>:critical</tt>, <tt>:moderate</tt> or +nil+ according to the
    # severity of _risk_index_.
    def of_risk_index(risk_index)
      rounded_risk_index = risk_index.round(8)
      return nil       if (rounded_risk_index < 1.0)
      return :moderate if (rounded_risk_index <= 2.0)
      :critical
    end
    
    # Returns <tt>:critical</tt>, <tt>:moderate</tt> or +nil+ according to the
    # severity of _skew_.
    def of_skew(skew)
      rounded_skew = skew.round(8)
      return nil       if (rounded_skew < 0.2)
      return :moderate if (rounded_skew <= 0.4)
      :critical
    end
    
  end
  
end

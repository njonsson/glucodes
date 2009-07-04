# Defines MeasurementsHelper.

# Provides view helpers to MeasurementsController views.
module MeasurementsHelper
  
  def date_time_column_header
    header = ''
    if @measurements.any? { |m| m.approximate_time? }
      header << content_tag(:span, '(≈ Approximate) ', :class => 'approximate')
    end
    header << 'Date/Time'
    header
  end
  
end

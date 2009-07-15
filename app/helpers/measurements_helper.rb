# Defines MeasurementsHelper.

# Provides view helpers to MeasurementsController views.
module MeasurementsHelper
  
  # Returns the text for the Average Measurement in Time Slot column header.
  def average_measurement_in_time_slot_column_header
    average_something_in_time_slot_column_header 'Measurement'
  end
  
  # Returns the text for the Average Skew in Time Slot column header.
  def average_skew_in_time_slot_column_header
    average_something_in_time_slot_column_header 'Skew'
  end
  
  # Returns the text for the Date/Time column header.
  def date_time_column_header
    header = ''
    if @measurements.any? { |m| m.approximate_time? }
      header = append_approximate_parenthesis(header)
    end
    header << 'Date/Time'
    header
  end
  
  # Returns _risk_grade_, marked up in HTML.
  def formatted_risk_grade(risk_grade)
    letter_grade, plus_or_minus = risk_grade.split('')
    return letter_grade unless plus_or_minus
    content = "#{letter_grade}#{plus_or_minus.gsub '-', '&ndash;'}"
    plus_or_minus_title = {'+' => 'plus', '-' => 'minus'}
    content_tag :abbr,
                content,
                :title => "#{letter_grade}-#{plus_or_minus_title[plus_or_minus]}"
  end
  
private
  
  def append_approximate_parenthesis(text)
    text + content_tag(:span, '(≈&nbsp;Approximate) ', :class => 'approximate')
  end
  
  # Returns the text for the Average Measurement in Time Slot column header.
  def average_something_in_time_slot_column_header(something)
    header = "Average #{something} in "
    if @dailies.any?(&:contains_approximate_times?)
      header = append_approximate_parenthesis(header)
    end
    header << 'Time Slot'
    header
  end
  
end

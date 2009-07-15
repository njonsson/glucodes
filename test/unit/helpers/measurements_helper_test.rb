require 'test_helper'

module MeasurementsHelperTest
  
  class AverageMeasurementInTimeSlotColumnHeader < ActionView::TestCase
    
    include MeasurementsHelper
    
    test 'should return expected text when @dailies is empty' do
      @dailies = []
      assert_equal 'Average Measurement in Time Slot',
                   average_measurement_in_time_slot_column_header
    end
    
    test 'should return expected text when @dailies contains no approximate times' do
      @dailies = [stub(:contains_approximate_times? => false)]
      assert_equal 'Average Measurement in Time Slot',
                   average_measurement_in_time_slot_column_header
    end
    
    test 'should return expected text when @dailies contains both an approximate time and an exact time' do
      @dailies = [stub(:contains_approximate_times? => true),
                  stub(:contains_approximate_times? => false)]
      assert_equal 'Average Measurement in <span class="approximate">(≈&nbsp;Approximate) </span>Time Slot',
                   average_measurement_in_time_slot_column_header
    end
    
  end
  
  class AverageSkewInTimeSlotColumnHeader < ActionView::TestCase
    
    include MeasurementsHelper
    
    test 'should return expected text when @dailies is empty' do
      @dailies = []
      assert_equal 'Average Skew in Time Slot',
                   average_skew_in_time_slot_column_header
    end
    
    test 'should return expected text when @dailies contains no approximate times' do
      @dailies = [stub(:contains_approximate_times? => false)]
      assert_equal 'Average Skew in Time Slot',
                   average_skew_in_time_slot_column_header
    end
    
    test 'should return expected text when @dailies contains both an approximate time and an exact time' do
      @dailies = [stub(:contains_approximate_times? => true),
                  stub(:contains_approximate_times? => false)]
      assert_equal 'Average Skew in <span class="approximate">(≈&nbsp;Approximate) </span>Time Slot',
                   average_skew_in_time_slot_column_header
    end
    
  end
  
  class DateTimeColumnHeader < ActionView::TestCase
    
    include MeasurementsHelper
    
    test 'should return expected text when @measurements is empty' do
      @measurements = []
      assert_equal 'Date/Time', date_time_column_header
    end
    
    test 'should return expected text when @measurements contains no approximate times' do
      @measurements = [stub(:approximate_time? => false)]
      assert_equal 'Date/Time', date_time_column_header
    end
    
    test 'should return expected text when @measurements contains both an approximate time and an exact time' do
      @measurements = [stub(:approximate_time? => true),
                       stub(:approximate_time? => false)]
      assert_equal '<span class="approximate">(≈&nbsp;Approximate) </span>Date/Time',
                   date_time_column_header
    end
    
  end
  
  class FormattedRiskGrade < ActionView::TestCase
    
    include MeasurementsHelper
    
    test 'should return unaltered grade when sent "A"' do
      assert_equal 'A', formatted_risk_grade('A')
    end
    
    test 'should return HTML-formatted grade when sent "B-"' do
      assert_equal '<abbr title="B-minus">B&ndash;</abbr>',
                   formatted_risk_grade('B-')
    end
    
    test 'should return HTML-formatted grade when sent "C+"' do
      assert_equal '<abbr title="C-plus">C+</abbr>',
                   formatted_risk_grade('C+')
    end
    
  end
  
end

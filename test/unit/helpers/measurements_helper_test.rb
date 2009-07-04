require 'test_helper'

module MeasurementsHelperTest
  
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
      assert_equal '<span class="approximate">(≈ Approximate) </span>Date/Time',
                   date_time_column_header
    end
    
  end
  
end

require File.dirname(__FILE__) + '/../test_helper'
require 'mocha'

class Measurement < ActiveRecord::Base; end

module MeasurementTest
  
  class Validations < ActiveSupport::TestCase
    
    def test_should_validate_presence_of_at_and_value
      Measurement.expects(:validates_presence_of).with :at, :value
      load 'app/models/measurement.rb'
    end
    
    def test_should_validate_uniqueness_of_at
      Measurement.expects(:validates_uniqueness_of).with :at, :allow_nil => true
      load 'app/models/measurement.rb'
    end
    
    def test_should_validate_length_of_time_period
      Measurement.expects(:validates_length_of).with :time_period,
                                                     :maximum => 1,
                                                     :allow_nil => true
      load 'app/models/measurement.rb'
    end
    
    def test_should_validate_numericality_of_value
      Measurement.expects(:validates_numericality_of).with :value,
                                                           :only_integer => true,
                                                           :greater_than => 0,
                                                           :allow_nil => true
      load 'app/models/measurement.rb'
    end
    
  end
  
  class Protections < ActiveSupport::TestCase
    
    def test_should_make_accessible_at_and_value
      Measurement.expects(:attr_accessible).with :at, :value
      load 'app/models/measurement.rb'
    end
    
  end
  
  module AdjustedDateAndTimePeriod
    
    class With045959At < ActiveSupport::TestCase
      
      def setup
        @measurement = Measurement.new(:at => '2007-12-09 4:59:59', :value => 100)
        @measurement.save!
      end
      
      def test_should_set_adjusted_date_to_day_before_at_when_saved
        assert_equal Time.parse('2007-12-08 4:59:59'), @measurement.adjusted_date
      end
      
      def test_should_set_time_period_to_g_when_saved
        assert_equal 'g', @measurement.time_period
      end
      
    end
    
    class With050000At < ActiveSupport::TestCase
      
      def setup
        @measurement = Measurement.new(:at => '2007-12-09 5:00', :value => 100)
        @measurement.save!
      end
      
      def test_should_set_adjusted_date_to_at_when_saved
        assert_equal Time.parse('2007-12-09 5:00'), @measurement.adjusted_date
      end
      
      def test_should_set_time_period_to_a_when_saved
        assert_equal 'a', @measurement.time_period
      end
      
    end
    
    class With075959At < ActiveSupport::TestCase
      
      def setup
        @measurement = Measurement.new(:at => '2007-12-09 7:59:59', :value => 100)
        @measurement.save!
      end
      
      def test_should_set_adjusted_date_to_at_when_saved
        assert_equal Time.parse('2007-12-09 7:59:59'), @measurement.adjusted_date
      end
      
      def test_should_set_time_period_to_a_when_saved
        assert_equal 'a', @measurement.time_period
      end
      
    end
    
    class With080000At < ActiveSupport::TestCase
      
      def setup
        @measurement = Measurement.new(:at => '2007-12-09 8:00', :value => 100)
        @measurement.save!
      end
      
      def test_should_set_adjusted_date_to_at_when_saved
        assert_equal Time.parse('2007-12-09 8:00'), @measurement.adjusted_date
      end
      
      def test_should_set_time_period_to_b_when_saved
        assert_equal 'b', @measurement.time_period
      end
      
    end
    
    class With105959At < ActiveSupport::TestCase
      
      def setup
        @measurement = Measurement.new(:at => '2007-12-09 10:59:59',
                                       :value => 100)
        @measurement.save!
      end
      
      def test_should_set_adjusted_date_to_at_when_saved
        assert_equal Time.parse('2007-12-09 10:59:59'), @measurement.adjusted_date
      end
      
      def test_should_set_time_period_to_b_when_saved
        assert_equal 'b', @measurement.time_period
      end
      
    end
    
    class With110000At < ActiveSupport::TestCase
      
      def setup
        @measurement = Measurement.new(:at => '2007-12-09 11:00', :value => 100)
        @measurement.save!
      end
      
      def test_should_set_adjusted_date_to_at_when_saved
        assert_equal Time.parse('2007-12-09 11:00'), @measurement.adjusted_date
      end
      
      def test_should_set_time_period_to_c_when_saved
        assert_equal 'c', @measurement.time_period
      end
      
    end
    
    class With135959At < ActiveSupport::TestCase
      
      def setup
        @measurement = Measurement.new(:at => '2007-12-09 13:59:59',
                                       :value => 100)
        @measurement.save!
      end
      
      def test_should_set_adjusted_date_to_at_when_saved
        assert_equal Time.parse('2007-12-09 13:59:59'), @measurement.adjusted_date
      end
      
      def test_should_set_time_period_to_c_when_saved
        assert_equal 'c', @measurement.time_period
      end
      
    end
    
    class With140000At < ActiveSupport::TestCase
      
      def setup
        @measurement = Measurement.new(:at => '2007-12-09 14:00', :value => 100)
        @measurement.save!
      end
      
      def test_should_set_adjusted_date_to_at_when_saved
        assert_equal Time.parse('2007-12-09 14:00'), @measurement.adjusted_date
      end
      
      def test_should_set_time_period_to_d_when_saved
        assert_equal 'd', @measurement.time_period
      end
      
    end
    
    class With165959At < ActiveSupport::TestCase
      
      def setup
        @measurement = Measurement.new(:at => '2007-12-09 16:59:59',
                                       :value => 100)
        @measurement.save!
      end
      
      def test_should_set_adjusted_date_to_at_when_saved
        assert_equal Time.parse('2007-12-09 16:59:59'), @measurement.adjusted_date
      end
      
      def test_should_set_time_period_to_d_when_saved
        assert_equal 'd', @measurement.time_period
      end
      
    end
    
    class With170000At < ActiveSupport::TestCase
      
      def setup
        @measurement = Measurement.new(:at => '2007-12-09 17:00', :value => 100)
        @measurement.save!
      end
      
      def test_should_set_adjusted_date_to_at_when_saved
        assert_equal Time.parse('2007-12-09 17:00'), @measurement.adjusted_date
      end
      
      def test_should_set_time_period_to_e_when_saved
        assert_equal 'e', @measurement.time_period
      end
      
    end
    
    class With195959At < ActiveSupport::TestCase
      
      def setup
        @measurement = Measurement.new(:at => '2007-12-09 19:59:59',
                                       :value => 100)
        @measurement.save!
      end
      
      def test_should_set_adjusted_date_to_at_when_saved
        assert_equal Time.parse('2007-12-09 19:59:59'), @measurement.adjusted_date
      end
      
      def test_should_set_time_period_to_e_when_saved
        assert_equal 'e', @measurement.time_period
      end
      
    end
    
    class With200000At < ActiveSupport::TestCase
      
      def setup
        @measurement = Measurement.new(:at => '2007-12-09 20:00', :value => 100)
        @measurement.save!
      end
      
      def test_should_set_adjusted_date_to_at_when_saved
        assert_equal Time.parse('2007-12-09 20:00'), @measurement.adjusted_date
      end
      
      def test_should_set_time_period_to_f_when_saved
        assert_equal 'f', @measurement.time_period
      end
      
    end
    
    class With225959At < ActiveSupport::TestCase
      
      def setup
        @measurement = Measurement.new(:at => '2007-12-09 22:59:59',
                                       :value => 100)
        @measurement.save!
      end
      
      def test_should_set_adjusted_date_to_at_when_saved
        assert_equal Time.parse('2007-12-09 22:59:59'), @measurement.adjusted_date
      end
      
      def test_should_set_time_period_to_f_when_saved
        assert_equal 'f', @measurement.time_period
      end
      
    end
    
    class With230000At < ActiveSupport::TestCase
      
      def setup
        @measurement = Measurement.new(:at => '2007-12-09 23:00', :value => 100)
        @measurement.save!
      end
      
      def test_should_set_adjusted_date_to_at_when_saved
        assert_equal Time.parse('2007-12-09 23:00'), @measurement.adjusted_date
      end
      
      def test_should_set_time_period_to_g_when_saved
        assert_equal 'g', @measurement.time_period
      end
      
    end
    
  end
  
end

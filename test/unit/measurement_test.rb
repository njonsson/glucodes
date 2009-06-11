require File.dirname(__FILE__) + '/../test_helper'
require 'mocha'

class Measurement < ActiveRecord::Base; end

module MeasurementTest
  
  class Validations < ActiveSupport::TestCase
    
    test 'should validate presence of at and value' do
      Measurement.expects(:validates_presence_of).with :at, :value
      load 'app/models/measurement.rb'
    end
    
    test 'should validate uniqueness of at' do
      Measurement.expects(:validates_uniqueness_of).with :at, :allow_nil => true
      load 'app/models/measurement.rb'
    end
    
    test 'should validate length of time_period and notes' do
      Measurement.expects(:validates_length_of).with :time_period,
                                                     :maximum => 1,
                                                     :allow_nil => true
      Measurement.expects(:validates_length_of).with :notes,
                                                     :maximum => 255,
                                                     :allow_nil => true
      load 'app/models/measurement.rb'
    end
    
    test 'should validate numericality of value' do
      Measurement.expects(:validates_numericality_of).with :value,
                                                           :only_integer => true,
                                                           :greater_than => 0,
                                                           :allow_nil => true
      load 'app/models/measurement.rb'
    end
    
  end
  
  class Protections < ActiveSupport::TestCase
    
    test 'should make accessible at and value' do
      Measurement.expects(:attr_accessible).with :at, :value
      load 'app/models/measurement.rb'
    end
    
  end
  
  module AdjustedDatesAndTimePeriod
    
    class With045959At < ActiveSupport::TestCase
      
      def setup
        @measurement = Measurement.new(:at => '2007-12-09 4:59:59', :value => 100)
        @measurement.save!
      end
      
      test 'should set adjusted_date to day before at when saved' do
        assert_equal Time.parse('2007-12-08 4:59:59 UTC'),
                     @measurement.adjusted_date
      end
      
      test 'should set time_period to g when saved' do
        assert_equal 'g', @measurement.time_period
      end
      
    end
    
    class With050000At < ActiveSupport::TestCase
      
      def setup
        @measurement = Measurement.new(:at => '2007-12-09 5:00', :value => 100)
        @measurement.save!
      end
      
      test 'should set adjusted_date to at when saved' do
        assert_equal Time.parse('2007-12-09 5:00 UTC'),
                     @measurement.adjusted_date
      end
      
      test 'should set time_period to "a" when saved' do
        assert_equal 'a', @measurement.time_period
      end
      
    end
    
    class With075959At < ActiveSupport::TestCase
      
      def setup
        @measurement = Measurement.new(:at => '2007-12-09 7:59:59', :value => 100)
        @measurement.save!
      end
      
      test 'should set adjusted_date to at when saved' do
        assert_equal Time.parse('2007-12-09 7:59:59 UTC'),
                     @measurement.adjusted_date
      end
      
      test 'should set time_period to "a" when saved' do
        assert_equal 'a', @measurement.time_period
      end
      
    end
    
    class With080000At < ActiveSupport::TestCase
      
      def setup
        @measurement = Measurement.new(:at => '2007-12-09 8:00', :value => 100)
        @measurement.save!
      end
      
      test 'should set adjusted_date to at when saved' do
        assert_equal Time.parse('2007-12-09 8:00 UTC'),
                     @measurement.adjusted_date
      end
      
      test 'should set time_period to "b" when saved' do
        assert_equal 'b', @measurement.time_period
      end
      
    end
    
    class With105959At < ActiveSupport::TestCase
      
      def setup
        @measurement = Measurement.new(:at => '2007-12-09 10:59:59',
                                       :value => 100)
        @measurement.save!
      end
      
      test 'should set adjusted_date to at when saved' do
        assert_equal Time.parse('2007-12-09 10:59:59 UTC'),
                     @measurement.adjusted_date
      end
      
      test 'should set time_period to "b" when saved' do
        assert_equal 'b', @measurement.time_period
      end
      
    end
    
    class With110000At < ActiveSupport::TestCase
      
      def setup
        @measurement = Measurement.new(:at => '2007-12-09 11:00', :value => 100)
        @measurement.save!
      end
      
      test 'should set adjusted_date to at when saved' do
        assert_equal Time.parse('2007-12-09 11:00 UTC'),
                     @measurement.adjusted_date
      end
      
      test 'should set time_period to "c" when saved' do
        assert_equal 'c', @measurement.time_period
      end
      
    end
    
    class With135959At < ActiveSupport::TestCase
      
      def setup
        @measurement = Measurement.new(:at => '2007-12-09 13:59:59',
                                       :value => 100)
        @measurement.save!
      end
      
      test 'should set adjusted_date to at when saved' do
        assert_equal Time.parse('2007-12-09 13:59:59 UTC'),
                     @measurement.adjusted_date
      end
      
      test 'should set time_period to "c" when saved' do
        assert_equal 'c', @measurement.time_period
      end
      
    end
    
    class With140000At < ActiveSupport::TestCase
      
      def setup
        @measurement = Measurement.new(:at => '2007-12-09 14:00', :value => 100)
        @measurement.save!
      end
      
      test 'should set adjusted_date to at when saved' do
        assert_equal Time.parse('2007-12-09 14:00 UTC'),
                     @measurement.adjusted_date
      end
      
      test 'should set time_period to "d" when saved' do
        assert_equal 'd', @measurement.time_period
      end
      
    end
    
    class With165959At < ActiveSupport::TestCase
      
      def setup
        @measurement = Measurement.new(:at => '2007-12-09 16:59:59',
                                       :value => 100)
        @measurement.save!
      end
      
      test 'should set adjusted_date to at when saved' do
        assert_equal Time.parse('2007-12-09 16:59:59 UTC'),
                     @measurement.adjusted_date
      end
      
      test 'should set time_period to "d" when saved' do
        assert_equal 'd', @measurement.time_period
      end
      
    end
    
    class With170000At < ActiveSupport::TestCase
      
      def setup
        @measurement = Measurement.new(:at => '2007-12-09 17:00', :value => 100)
        @measurement.save!
      end
      
      test 'should set adjusted_date to at when saved' do
        assert_equal Time.parse('2007-12-09 17:00 UTC'),
                     @measurement.adjusted_date
      end
      
      test 'should set time_period to "e" when saved' do
        assert_equal 'e', @measurement.time_period
      end
      
    end
    
    class With195959At < ActiveSupport::TestCase
      
      def setup
        @measurement = Measurement.new(:at => '2007-12-09 19:59:59',
                                       :value => 100)
        @measurement.save!
      end
      
      test 'should set adjusted_date to at when saved' do
        assert_equal Time.parse('2007-12-09 19:59:59 UTC'),
                     @measurement.adjusted_date
      end
      
      test 'should set time_period to "e" when saved' do
        assert_equal 'e', @measurement.time_period
      end
      
    end
    
    class With200000At < ActiveSupport::TestCase
      
      def setup
        @measurement = Measurement.new(:at => '2007-12-09 20:00', :value => 100)
        @measurement.save!
      end
      
      test 'should set adjusted_date to at when saved' do
        assert_equal Time.parse('2007-12-09 20:00 UTC'),
                     @measurement.adjusted_date
      end
      
      test 'should set time_period to "f" when saved' do
        assert_equal 'f', @measurement.time_period
      end
      
    end
    
    class With225959At < ActiveSupport::TestCase
      
      def setup
        @measurement = Measurement.new(:at => '2007-12-09 22:59:59',
                                       :value => 100)
        @measurement.save!
      end
      
      test 'should set adjusted_date to at when saved' do
        assert_equal Time.parse('2007-12-09 22:59:59 UTC'),
                     @measurement.adjusted_date
      end
      
      test 'should set time_period to "f" when saved' do
        assert_equal 'f', @measurement.time_period
      end
      
    end
    
    class With230000At < ActiveSupport::TestCase
      
      def setup
        @measurement = Measurement.new(:at => '2007-12-09 23:00', :value => 100)
        @measurement.save!
      end
      
      test 'should set adjusted_date to at when saved' do
        assert_equal Time.parse('2007-12-09 23:00 UTC'),
                     @measurement.adjusted_date
      end
      
      test 'should set time_period to "g" when saved' do
        assert_equal 'g', @measurement.time_period
      end
      
    end
    
    class WithMarchAt < ActiveSupport::TestCase
      
      def setup
        @measurement = Measurement.new(:at => '2009-03-31 12:00', :value => 100)
        @measurement.save!
      end
      
      test 'should set adjusted_end_of_quarter_date to end of Q1 for adjusted_date when saved' do
        assert_equal Time.parse('2009-03-31 23:59:59 UTC'),
                     @measurement.adjusted_end_of_quarter_date
      end
      
    end
    
    class WithAprilAt < ActiveSupport::TestCase
      
      def setup
        @measurement = Measurement.new(:at => '2009-04-01 12:00', :value => 100)
        @measurement.save!
      end
      
      test 'should set adjusted_end_of_quarter_date to end of Q2 for adjusted_date when saved' do
        assert_equal Time.parse('2009-06-30 23:59:59 UTC'),
                     @measurement.adjusted_end_of_quarter_date
      end
      
    end
    
  end
  
end

require File.dirname(__FILE__) + '/../test_helper'

module MeasurementTest
  
  class MissingAtAndValue < ActiveSupport::TestCase
    
    def setup
      @measurement = Measurement.new
      @measurement.valid?
    end
    
    test 'should have presence validation error on at' do
      assert_equal "can't be blank", @measurement.errors.on(:at)
    end
    
    test 'should have presence validation error on value' do
      assert_equal "can't be blank", @measurement.errors.on(:value)
    end
    
  end
  
  class WithNonuniqueAt < ActiveSupport::TestCase
    
    def setup
      Measurement.create! :at => '2009-06-10 20:49', :value => 100
      @measurement = Measurement.new(:at => '2009-06-10 20:49')
      @measurement.valid?
    end
    
    test 'should have uniqueness validation error on at' do
      assert_equal 'has already been taken', @measurement.errors.on(:at)
    end
    
  end
  
  class WithNonnumericValue < ActiveSupport::TestCase
    
    def setup
      @measurement = Measurement.new(:value => 'foo')
      @measurement.valid?
    end
    
    test 'should have numericality validation error on value' do
      assert_equal 'is not a number', @measurement.errors.on(:value)
    end
    
  end
  
  class WithZeroValue < ActiveSupport::TestCase
    
    def setup
      @measurement = Measurement.new(:value => 0)
      @measurement.valid?
    end
    
    test 'should have numericality range validation error on value' do
      assert_equal 'must be greater than 0', @measurement.errors.on(:value)
    end
    
  end
  
  class WithLongNotes < ActiveSupport::TestCase
    
    def setup
      @measurement = Measurement.new(:notes => 'a' * 257)
      @measurement.valid?
    end
    
    test 'should have length validation error on value' do
      assert_equal 'is too long (maximum is 255 characters)',
                   @measurement.errors.on(:notes)
    end
    
  end
  
  class Protections < ActiveSupport::TestCase
    
    test 'should protect id' do
      assert_nil Measurement.new(:id => 123).id
    end
    
    test 'should not protect at' do
      time = Time.parse('2009-06-10 22:49 UTC')
      assert_equal time, Measurement.new(:at => time).at
    end
    
    test 'should not protect approximate_time' do
      assert_equal true,
                   Measurement.new(:approximate_time => true).approximate_time
      assert_equal false,
                   Measurement.new(:approximate_time => false).approximate_time
    end
    
    test 'should protect adjusted_date' do
      assert_nil Measurement.new(:adjusted_date => '2009-06-10').adjusted_date
    end
    
    test 'should protect time_slot' do
      assert_nil Measurement.new(:time_slot => 'a').time_slot
    end
    
    test 'should not protect value' do
      assert_equal 123, Measurement.new(:value => 123).value
    end
    
    test 'should protect skew' do
      assert_nil Measurement.new(:skew => 0.5).skew
    end
    
    test 'should not protect notes' do
      assert_equal 'foo', Measurement.new(:notes => 'foo').notes
    end
    
    test 'should protect created_at' do
      assert_nil Measurement.new(:created_at => '2009-06-10').created_at
    end
    
    test 'should protect updated_at' do
      assert_nil Measurement.new(:updated_at => '2009-06-10').updated_at
    end
    
  end
  
  module AdjustedDateAndTimeSlotAndSkew
    
    class With045959At < ActiveSupport::TestCase
      
      def setup
        @measurement = Measurement.create!(:at => '2007-12-09 4:59:59',
                                           :value => 100)
      end
      
      test 'should set adjusted_date to day before at when saved' do
        assert_equal Date.parse('2007-12-08'), @measurement.adjusted_date
      end
      
      test 'should set time_slot to g when saved' do
        assert_equal 'g', @measurement.time_slot
      end
      
    end
    
    class With050000At < ActiveSupport::TestCase
      
      def setup
        @measurement = Measurement.create!(:at => '2007-12-09 5:00',
                                           :value => 100)
      end
      
      test 'should set adjusted_date to at when saved' do
        assert_equal Date.parse('2007-12-09'), @measurement.adjusted_date
      end
      
      test 'should set time_slot to "a" when saved' do
        assert_equal 'a', @measurement.time_slot
      end
      
    end
    
    class With075959At < ActiveSupport::TestCase
      
      def setup
        @measurement = Measurement.create!(:at => '2007-12-09 7:59:59',
                                           :value => 100)
      end
      
      test 'should set adjusted_date to at when saved' do
        assert_equal Date.parse('2007-12-09'), @measurement.adjusted_date
      end
      
      test 'should set time_slot to "a" when saved' do
        assert_equal 'a', @measurement.time_slot
      end
      
    end
    
    class With080000At < ActiveSupport::TestCase
      
      def setup
        @measurement = Measurement.create!(:at => '2007-12-09 8:00',
                                           :value => 100)
      end
      
      test 'should set adjusted_date to at when saved' do
        assert_equal Date.parse('2007-12-09'), @measurement.adjusted_date
      end
      
      test 'should set time_slot to "b" when saved' do
        assert_equal 'b', @measurement.time_slot
      end
      
    end
    
    class With105959At < ActiveSupport::TestCase
      
      def setup
        @measurement = Measurement.create!(:at => '2007-12-09 10:59:59',
                                           :value => 100)
      end
      
      test 'should set adjusted_date to at when saved' do
        assert_equal Date.parse('2007-12-09'), @measurement.adjusted_date
      end
      
      test 'should set time_slot to "b" when saved' do
        assert_equal 'b', @measurement.time_slot
      end
      
    end
    
    class With110000At < ActiveSupport::TestCase
      
      def setup
        @measurement = Measurement.create!(:at => '2007-12-09 11:00',
                                           :value => 100)
      end
      
      test 'should set adjusted_date to at when saved' do
        assert_equal Date.parse('2007-12-09'), @measurement.adjusted_date
      end
      
      test 'should set time_slot to "c" when saved' do
        assert_equal 'c', @measurement.time_slot
      end
      
    end
    
    class With135959At < ActiveSupport::TestCase
      
      def setup
        @measurement = Measurement.create!(:at => '2007-12-09 13:59:59',
                                           :value => 100)
      end
      
      test 'should set adjusted_date to at when saved' do
        assert_equal Date.parse('2007-12-09'), @measurement.adjusted_date
      end
      
      test 'should set time_slot to "c" when saved' do
        assert_equal 'c', @measurement.time_slot
      end
      
    end
    
    class With140000At < ActiveSupport::TestCase
      
      def setup
        @measurement = Measurement.create!(:at => '2007-12-09 14:00',
                                           :value => 100)
      end
      
      test 'should set adjusted_date to at when saved' do
        assert_equal Date.parse('2007-12-09'), @measurement.adjusted_date
      end
      
      test 'should set time_slot to "d" when saved' do
        assert_equal 'd', @measurement.time_slot
      end
      
    end
    
    class With165959At < ActiveSupport::TestCase
      
      def setup
        @measurement = Measurement.create!(:at => '2007-12-09 16:59:59',
                                           :value => 100)
      end
      
      test 'should set adjusted_date to at when saved' do
        assert_equal Date.parse('2007-12-09'), @measurement.adjusted_date
      end
      
      test 'should set time_slot to "d" when saved' do
        assert_equal 'd', @measurement.time_slot
      end
      
    end
    
    class With170000At < ActiveSupport::TestCase
      
      def setup
        @measurement = Measurement.create!(:at => '2007-12-09 17:00',
                                           :value => 100)
      end
      
      test 'should set adjusted_date to at when saved' do
        assert_equal Date.parse('2007-12-09'), @measurement.adjusted_date
      end
      
      test 'should set time_slot to "e" when saved' do
        assert_equal 'e', @measurement.time_slot
      end
      
    end
    
    class With195959At < ActiveSupport::TestCase
      
      def setup
        @measurement = Measurement.create!(:at => '2007-12-09 19:59:59',
                                           :value => 100)
      end
      
      test 'should set adjusted_date to at when saved' do
        assert_equal Date.parse('2007-12-09'), @measurement.adjusted_date
      end
      
      test 'should set time_slot to "e" when saved' do
        assert_equal 'e', @measurement.time_slot
      end
      
    end
    
    class With200000At < ActiveSupport::TestCase
      
      def setup
        @measurement = Measurement.create!(:at => '2007-12-09 20:00',
                                           :value => 100)
      end
      
      test 'should set adjusted_date to at when saved' do
        assert_equal Date.parse('2007-12-09'), @measurement.adjusted_date
      end
      
      test 'should set time_slot to "f" when saved' do
        assert_equal 'f', @measurement.time_slot
      end
      
    end
    
    class With225959At < ActiveSupport::TestCase
      
      def setup
        @measurement = Measurement.create!(:at => '2007-12-09 22:59:59',
                                           :value => 100)
      end
      
      test 'should set adjusted_date to at when saved' do
        assert_equal Date.parse('2007-12-09'), @measurement.adjusted_date
      end
      
      test 'should set time_slot to "f" when saved' do
        assert_equal 'f', @measurement.time_slot
      end
      
    end
    
    class With230000At < ActiveSupport::TestCase
      
      def setup
        @measurement = Measurement.create!(:at => '2007-12-09 23:00',
                                           :value => 100)
      end
      
      test 'should set adjusted_date to at when saved' do
        assert_equal Date.parse('2007-12-09'), @measurement.adjusted_date
      end
      
      test 'should set time_slot to "g" when saved' do
        assert_equal 'g', @measurement.time_slot
      end
      
    end
    
  end
  
  module SkewAndSeverity
    
    class With50Value < ActiveSupport::TestCase
      
      def setup
        @measurement = Measurement.create!(:at => '2009-01-01 12:00',
                                           :value => 50)
      end
      
      test 'should set skew to 0.5 when saved' do
        assert_equal 0.5, @measurement.skew.round(2)
      end
      
      test 'should return :critical when sent severity' do
        assert_equal :critical, @measurement.severity
      end
      
    end
    
    class With80Value < ActiveSupport::TestCase
      
      def setup
        @measurement = Measurement.create!(:at => '2009-01-01 12:00',
                                           :value => 80)
      end
      
      test 'should set skew to 0.2 when saved' do
        assert_equal 0.2, @measurement.skew.round(2)
      end
      
      test 'should return :moderate when sent severity' do
        assert_equal :moderate, @measurement.severity
      end
      
    end
    
    class With100Value < ActiveSupport::TestCase
      
      def setup
        @measurement = Measurement.create!(:at => '2009-01-01 12:00',
                                           :value => 100)
      end
      
      test 'should set skew to 0 when saved' do
        assert_equal 0.0, @measurement.skew.round(2)
      end
      
      test 'should return nil when sent severity' do
        assert_nil @measurement.severity
      end
      
    end
    
    class With125Value < ActiveSupport::TestCase
      
      def setup
        @measurement = Measurement.create!(:at => '2009-01-01 12:00',
                                           :value => 125)
      end
      
      test 'should set skew to 0.2 when saved' do
        assert_equal 0.2, @measurement.skew.round(2)
      end
      
      test 'should return :moderate when sent severity' do
        assert_equal :moderate, @measurement.severity
      end
      
    end
    
    class With200Value < ActiveSupport::TestCase
      
      def setup
        @measurement = Measurement.create!(:at => '2009-01-01 12:00',
                                           :value => 200)
      end
      
      test 'should set skew to 0.5 when saved' do
        assert_equal 0.5, @measurement.skew.round(2)
      end
      
      test 'should return :critical when sent severity' do
        assert_equal :critical, @measurement.severity
      end
      
    end
    
  end
  
end

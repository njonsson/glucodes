require File.dirname(__FILE__) + '/../test_helper'

module MeasurementTest
  
  module ClassMethods
    
    class SkewOf < ActiveSupport::TestCase
      
      test 'should return 0.5 when sent with 50' do
        assert_equal 0.5, Measurement.skew_of(50)
      end
      
      test 'should return 0.2 when sent with 80' do
        assert_in_delta 0.2, Measurement.skew_of(80), 0.000001
      end
      
      test 'should return 0.0 when sent with 100' do
        actual = Measurement.skew_of(100)
        assert_equal 0.0, actual
        assert_instance_of Float, actual
      end
      
      test 'should return 0.2 when sent with 125' do
        assert_in_delta 0.2, Measurement.skew_of(125), 0.000001
      end
      
      test 'should return 0.5 when sent with 200' do
        assert_equal 0.5, Measurement.skew_of(200)
      end
      
    end
    
  end
  
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
  
  module AdjustedDateAndTimeSlot
    
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
  
  class Save < ActiveSupport::TestCase
    
    class WithAssortedDatesAndValues < ActiveSupport::TestCase
      
      def do_create_measurements
        @skews = []
        @skews << Measurement.create!(:at => '2009-06-26 08:00',
                                      :value => 70,
                                      :notes => 'Foo').skew
        @skews << Measurement.create!(:at => '2009-06-26 16:00',
                                      :value => 120,
                                      :notes => 'Bar').skew
        @skews << Measurement.create!(:at => '2009-06-27 08:00',
                                      :value => 80,
                                      :approximate_time => true,
                                      :notes => 'Baz').skew
        @skews << Measurement.create!(:at => '2009-06-27 16:00',
                                      :value => 115).skew
      end
      
      test 'should create the expected number of Daily Aggregate records' do
        assert_difference %w(Aggregate.count Daily.count), 2 do
          do_create_measurements
        end
      end
      
      test 'should create expected Daily records with the expected period_ends_on values' do
        do_create_measurements
        assert_equal [Date.parse('2009-06-27'), Date.parse('2009-06-26')],
                     Daily.all.collect(&:period_ends_on)
      end
      
      test 'should create expected Daily records with the expected contains_approximate_times values' do
        do_create_measurements
        assert_equal [true, false],
                     Daily.all.collect(&:contains_approximate_times)
      end
      
      test 'should create expected Daily records with the expected average_value values' do
        do_create_measurements
        assert_equal [Math.mean(80, 115), Math.mean(70, 120)],
                     Daily.all.collect(&:average_value)
      end
      
      test 'should create expected Daily records with the expected standard_deviation_of_value values' do
        do_create_measurements
        assert_equal [Math.stddevp(80, 115), Math.stddevp(70, 120)],
                     Daily.all.collect(&:standard_deviation_of_value)
      end
      
      test 'should create expected Daily records with the expected maximum_value values' do
        do_create_measurements
        assert_equal [115, 120], Daily.all.collect(&:maximum_value)
      end
      
      test 'should create expected Daily records with the expected minimum_value values' do
        do_create_measurements
        assert_equal [80, 70], Daily.all.collect(&:minimum_value)
      end
      
      test 'should create expected Daily records with the expected average_skew values' do
        do_create_measurements
        assert_equal [Math.mean(*@skews[2..3]).round(6),
                      Math.mean(*@skews[0..1]).round(6)],
                     Daily.all.collect { |d| d.average_skew.round 6 }
      end
      
      test 'should create expected Daily records with the expected average_value_in_time_slot_a values' do
        do_create_measurements
        assert_equal [nil, nil],
                     Daily.all.collect(&:average_value_in_time_slot_a)
      end
      
      test 'should create expected Daily records with the expected average_value_in_time_slot_b values' do
        do_create_measurements
        assert_equal [80, 70], Daily.all.collect(&:average_value_in_time_slot_b)
      end
      
      test 'should create expected Daily records with the expected average_value_in_time_slot_c values' do
        do_create_measurements
        assert_equal [nil, nil],
                     Daily.all.collect(&:average_value_in_time_slot_c)
      end
      
      test 'should create expected Daily records with the expected average_value_in_time_slot_d values' do
        do_create_measurements
        assert_equal [115, 120],
                     Daily.all.collect(&:average_value_in_time_slot_d)
      end
      
      test 'should create expected Daily records with the expected average_value_in_time_slot_e values' do
        do_create_measurements
        assert_equal [nil, nil],
                     Daily.all.collect(&:average_value_in_time_slot_e)
      end
      
      test 'should create expected Daily records with the expected average_value_in_time_slot_f values' do
        do_create_measurements
        assert_equal [nil, nil],
                     Daily.all.collect(&:average_value_in_time_slot_f)
      end
      
      test 'should create expected Daily records with the expected average_skew_in_time_slot_a values' do
        do_create_measurements
        assert_equal [nil, nil],
                     Daily.all.collect(&:average_skew_in_time_slot_a)
      end
      
      test 'should create expected Daily records with the expected average_skew_in_time_slot_b values' do
        do_create_measurements
        assert_equal [@skews[2].round(6), @skews[0].round(6)],
                     Daily.all.collect { |d| d.average_skew_in_time_slot_b.round 6 }
      end
      
      test 'should create expected Daily records with the expected average_skew_in_time_slot_c values' do
        do_create_measurements
        assert_equal [nil, nil],
                     Daily.all.collect(&:average_skew_in_time_slot_c)
      end
      
      test 'should create expected Daily records with the expected average_skew_in_time_slot_d values' do
        do_create_measurements
        assert_equal [@skews[3].round(6), @skews[1].round(6)],
                     Daily.all.collect { |d| d.average_skew_in_time_slot_d.round 6 }
      end
      
      test 'should create expected Daily records with the expected average_skew_in_time_slot_e values' do
        do_create_measurements
        assert_equal [nil, nil],
                     Daily.all.collect(&:average_skew_in_time_slot_e)
      end
      
      test 'should create expected Daily records with the expected average_skew_in_time_slot_f values' do
        do_create_measurements
        assert_equal [nil, nil],
                     Daily.all.collect(&:average_skew_in_time_slot_f)
      end
      
      test 'should create expected Daily records with the expected notes values' do
        do_create_measurements
        assert_equal ["Baz", "Foo\n\nBar"], Daily.all.collect(&:notes)
      end
      
    end
    
    def setup
      @measurement = Measurement.new(:at => '2009-07-06 21:11', :value => 123)
      Measurement.stubs(:skew_of).returns 0.123456
    end
    
    test 'should call Measurement.skew_of with value' do
      Measurement.expects(:skew_of).with(123).returns 0.123456
      @measurement.save
    end
    
    test 'should set skew to the return value of Measurement.skew_of' do
      @measurement.save
      assert_equal 0.123456, @measurement.skew
    end
    
  end
  
  class Severity_ < ActiveSupport::TestCase
    
    def setup
      @measurement = Measurement.new
      @measurement.stubs(:skew).returns :a_skew
      Severity.stubs(:of_skew).returns :a_severity
    end
    
    test 'should call Severity.of_skew with skew' do
      Severity.expects(:of_skew).with :a_skew
      @measurement.severity
    end
    
    test 'should return the return value of Severity.of_skew' do
      assert_equal :a_severity, @measurement.severity
    end
    
  end
  
end

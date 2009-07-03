require File.dirname(__FILE__) + '/../test_helper'
require 'mocha'

module DailyTest
  
  class MissingRequiredAttributes < ActiveSupport::TestCase
    
    def setup
      @daily = Daily.new
      @daily.valid?
    end
    
    test 'should have presence validation error on period_ends_on' do
      assert_equal "can't be blank", @daily.errors.on(:period_ends_on)
    end
    
    test 'should have presence validation error on average_value' do
      assert_equal "can't be blank", @daily.errors.on(:average_value)
    end
    
    test 'should have presence validation error on standard_deviation_of_value' do
      assert_equal "can't be blank",
                   @daily.errors.on(:standard_deviation_of_value)
    end
    
    test 'should have presence validation error on maximum_value' do
      assert_equal "can't be blank", @daily.errors.on(:maximum_value)
    end
    
    test 'should have presence validation error on minimum_value' do
      assert_equal "can't be blank", @daily.errors.on(:minimum_value)
    end
    
    test 'should have presence validation error on average_skew' do
      assert_equal "can't be blank", @daily.errors.on(:average_skew)
    end
    
  end
  
  class WithNonuniquePeriodEndsOn < ActiveSupport::TestCase
    
    def setup
      Daily.create! :period_ends_on => '2009-06-27',
                    :average_value => 100,
                    :standard_deviation_of_value => 50,
                    :maximum_value => 200,
                    :minimum_value => 50,
                    :average_skew => 0.25
      @daily = Daily.new(:period_ends_on => '2009-06-27')
      @daily.valid?
    end
    
    test 'should have uniqueness validation error on period_ends_on' do
      assert_equal 'has already been taken', @daily.errors.on(:period_ends_on)
    end
    
  end
  
  class WithNonnumericAverageValue < ActiveSupport::TestCase
    
    def setup
      @daily = Daily.new(:average_value => 'foo')
      @daily.valid?
    end
    
    test 'should have numericality validation error on average_value' do
      assert_equal 'is not a number', @daily.errors.on(:average_value)
    end
    
  end
  
  class WithZeroAverageValue < ActiveSupport::TestCase
    
    def setup
      @daily = Daily.new(:average_value => 0)
      @daily.valid?
    end
    
    test 'should have numericality range validation error on average_value' do
      assert_equal 'must be greater than 0', @daily.errors.on(:average_value)
    end
    
  end
  
  class WithNonnumericStandardDeviationOfValue < ActiveSupport::TestCase
    
    def setup
      @daily = Daily.new(:standard_deviation_of_value => 'foo')
      @daily.valid?
    end
    
    test 'should have numericality validation error on standard_deviation_of_value' do
      assert_equal 'is not a number',
                   @daily.errors.on(:standard_deviation_of_value)
    end
    
  end
  
  class WithNegativeStandardDeviationOfValue < ActiveSupport::TestCase
    
    def setup
      @daily = Daily.new(:standard_deviation_of_value => -0.1)
      @daily.valid?
    end
    
    test 'should have numericality range validation error on standard_deviation_of_value' do
      assert_equal 'must be greater than or equal to 0',
                   @daily.errors.on(:standard_deviation_of_value)
    end
    
  end
  
  class WithNonnumericMaximumValue < ActiveSupport::TestCase
    
    def setup
      @daily = Daily.new(:maximum_value => 'foo')
      @daily.valid?
    end
    
    test 'should have numericality validation error on maximum_value' do
      assert_equal 'is not a number', @daily.errors.on(:maximum_value)
    end
    
  end
  
  class WithZeroMaximumValue < ActiveSupport::TestCase
    
    def setup
      @daily = Daily.new(:maximum_value => 0)
      @daily.valid?
    end
    
    test 'should have numericality range validation error on maximum_value' do
      assert_equal 'must be greater than 0', @daily.errors.on(:maximum_value)
    end
    
  end
  
  class WithNonnumericMinimumValue < ActiveSupport::TestCase
    
    def setup
      @daily = Daily.new(:minimum_value => 'foo')
      @daily.valid?
    end
    
    test 'should have numericality validation error on minimum_value' do
      assert_equal 'is not a number', @daily.errors.on(:minimum_value)
    end
    
  end
  
  class WithZeroMinimumValue < ActiveSupport::TestCase
    
    def setup
      @daily = Daily.new(:minimum_value => 0)
      @daily.valid?
    end
    
    test 'should have numericality range validation error on minimum_value' do
      assert_equal 'must be greater than 0', @daily.errors.on(:minimum_value)
    end
    
  end
  
  class WithNonnumericAverageSkew < ActiveSupport::TestCase
    
    def setup
      @daily = Daily.new(:average_skew => 'foo')
      @daily.valid?
    end
    
    test 'should have numericality validation error on average_skew' do
      assert_equal 'is not a number', @daily.errors.on(:average_skew)
    end
    
  end
  
  class WithNegativeAverageSkew < ActiveSupport::TestCase
    
    def setup
      @daily = Daily.new(:average_skew => -0.1)
      @daily.valid?
    end
    
    test 'should have numericality range validation error on average_skew' do
      assert_equal 'must be greater than or equal to 0',
                   @daily.errors.on(:average_skew)
    end
    
  end
  
  class WithNonnumericAverageValueInTimeSlotA < ActiveSupport::TestCase
    
    def setup
      @daily = Daily.new(:average_value_in_time_slot_a => 'foo')
      @daily.valid?
    end
    
    test 'should have numericality validation error on average_value_in_time_slot_a' do
      assert_equal 'is not a number',
                   @daily.errors.on(:average_value_in_time_slot_a)
    end
    
  end
  
  class WithZeroAverageValueInTimeSlotA < ActiveSupport::TestCase
    
    def setup
      @daily = Daily.new(:average_value_in_time_slot_a => 0)
      @daily.valid?
    end
    
    test 'should have numericality range validation error on average_value_in_time_slot_a' do
      assert_equal 'must be greater than 0',
                   @daily.errors.on(:average_value_in_time_slot_a)
    end
    
  end
  
  class WithNonnumericAverageValueInTimeSlotB < ActiveSupport::TestCase
    
    def setup
      @daily = Daily.new(:average_value_in_time_slot_b => 'foo')
      @daily.valid?
    end
    
    test 'should have numericality validation error on average_value_in_time_slot_b' do
      assert_equal 'is not a number',
                   @daily.errors.on(:average_value_in_time_slot_b)
    end
    
  end
  
  class WithZeroAverageValueInTimeSlotB < ActiveSupport::TestCase
    
    def setup
      @daily = Daily.new(:average_value_in_time_slot_b => 0)
      @daily.valid?
    end
    
    test 'should have numericality range validation error on average_value_in_time_slot_b' do
      assert_equal 'must be greater than 0',
                   @daily.errors.on(:average_value_in_time_slot_b)
    end
    
  end
  
  class WithNonnumericAverageValueInTimeSlotC < ActiveSupport::TestCase
    
    def setup
      @daily = Daily.new(:average_value_in_time_slot_c => 'foo')
      @daily.valid?
    end
    
    test 'should have numericality validation error on average_value_in_time_slot_c' do
      assert_equal 'is not a number',
                   @daily.errors.on(:average_value_in_time_slot_c)
    end
    
  end
  
  class WithZeroAverageValueInTimeSlotC < ActiveSupport::TestCase
    
    def setup
      @daily = Daily.new(:average_value_in_time_slot_c => 0)
      @daily.valid?
    end
    
    test 'should have numericality range validation error on average_value_in_time_slot_c' do
      assert_equal 'must be greater than 0',
                   @daily.errors.on(:average_value_in_time_slot_c)
    end
    
  end
  
  class WithNonnumericAverageValueInTimeSlotD < ActiveSupport::TestCase
    
    def setup
      @daily = Daily.new(:average_value_in_time_slot_d => 'foo')
      @daily.valid?
    end
    
    test 'should have numericality validation error on average_value_in_time_slot_d' do
      assert_equal 'is not a number',
                   @daily.errors.on(:average_value_in_time_slot_d)
    end
    
  end
  
  class WithZeroAverageValueInTimeSlotD < ActiveSupport::TestCase
    
    def setup
      @daily = Daily.new(:average_value_in_time_slot_d => 0)
      @daily.valid?
    end
    
    test 'should have numericality range validation error on average_value_in_time_slot_d' do
      assert_equal 'must be greater than 0',
                   @daily.errors.on(:average_value_in_time_slot_d)
    end
    
  end
  
  class WithNonnumericAverageValueInTimeSlotE < ActiveSupport::TestCase
    
    def setup
      @daily = Daily.new(:average_value_in_time_slot_e => 'foo')
      @daily.valid?
    end
    
    test 'should have numericality validation error on average_value_in_time_slot_e' do
      assert_equal 'is not a number',
                   @daily.errors.on(:average_value_in_time_slot_e)
    end
    
  end
  
  class WithZeroAverageValueInTimeSlotE < ActiveSupport::TestCase
    
    def setup
      @daily = Daily.new(:average_value_in_time_slot_e => 0)
      @daily.valid?
    end
    
    test 'should have numericality range validation error on average_value_in_time_slot_e' do
      assert_equal 'must be greater than 0',
                   @daily.errors.on(:average_value_in_time_slot_e)
    end
    
  end
  
  class WithNonnumericAverageValueInTimeSlotF < ActiveSupport::TestCase
    
    def setup
      @daily = Daily.new(:average_value_in_time_slot_f => 'foo')
      @daily.valid?
    end
    
    test 'should have numericality validation error on average_value_in_time_slot_f' do
      assert_equal 'is not a number',
                   @daily.errors.on(:average_value_in_time_slot_f)
    end
    
  end
  
  class WithZeroAverageValueInTimeSlotF < ActiveSupport::TestCase
    
    def setup
      @daily = Daily.new(:average_value_in_time_slot_f => 0)
      @daily.valid?
    end
    
    test 'should have numericality range validation error on average_value_in_time_slot_f' do
      assert_equal 'must be greater than 0',
                   @daily.errors.on(:average_value_in_time_slot_f)
    end
    
  end
  
  class WithNonnumericAverageSkewInTimeSlotA < ActiveSupport::TestCase
    
    def setup
      @daily = Daily.new(:average_skew_in_time_slot_a => 'foo')
      @daily.valid?
    end
    
    test 'should have numericality validation error on average_skew_in_time_slot_a' do
      assert_equal 'is not a number',
                   @daily.errors.on(:average_skew_in_time_slot_a)
    end
    
  end
  
  class WithNegativeAverageSkewInTimeSlotA < ActiveSupport::TestCase
    
    def setup
      @daily = Daily.new(:average_skew_in_time_slot_a => -0.1)
      @daily.valid?
    end
    
    test 'should have numericality range validation error on average_skew_in_time_slot_a' do
      assert_equal 'must be greater than or equal to 0',
                   @daily.errors.on(:average_skew_in_time_slot_a)
    end
    
  end
  
  class WithNonnumericAverageSkewInTimeSlotB < ActiveSupport::TestCase
    
    def setup
      @daily = Daily.new(:average_skew_in_time_slot_b => 'foo')
      @daily.valid?
    end
    
    test 'should have numericality validation error on average_skew_in_time_slot_b' do
      assert_equal 'is not a number',
                   @daily.errors.on(:average_skew_in_time_slot_b)
    end
    
  end
  
  class WithNegativeAverageSkewInTimeSlotB < ActiveSupport::TestCase
    
    def setup
      @daily = Daily.new(:average_skew_in_time_slot_b => -0.1)
      @daily.valid?
    end
    
    test 'should have numericality range validation error on average_skew_in_time_slot_b' do
      assert_equal 'must be greater than or equal to 0',
                   @daily.errors.on(:average_skew_in_time_slot_b)
    end
    
  end
  
  class WithNonnumericAverageSkewInTimeSlotC < ActiveSupport::TestCase
    
    def setup
      @daily = Daily.new(:average_skew_in_time_slot_c => 'foo')
      @daily.valid?
    end
    
    test 'should have numericality validation error on average_skew_in_time_slot_c' do
      assert_equal 'is not a number',
                   @daily.errors.on(:average_skew_in_time_slot_c)
    end
    
  end
  
  class WithNegativeAverageSkewInTimeSlotC < ActiveSupport::TestCase
    
    def setup
      @daily = Daily.new(:average_skew_in_time_slot_c => -0.1)
      @daily.valid?
    end
    
    test 'should have numericality range validation error on average_skew_in_time_slot_c' do
      assert_equal 'must be greater than or equal to 0',
                   @daily.errors.on(:average_skew_in_time_slot_c)
    end
    
  end
  
  class WithNonnumericAverageSkewInTimeSlotD < ActiveSupport::TestCase
    
    def setup
      @daily = Daily.new(:average_skew_in_time_slot_d => 'foo')
      @daily.valid?
    end
    
    test 'should have numericality validation error on average_skew_in_time_slot_d' do
      assert_equal 'is not a number',
                   @daily.errors.on(:average_skew_in_time_slot_d)
    end
    
  end
  
  class WithNegativeAverageSkewInTimeSlotD < ActiveSupport::TestCase
    
    def setup
      @daily = Daily.new(:average_skew_in_time_slot_d => -0.1)
      @daily.valid?
    end
    
    test 'should have numericality range validation error on average_skew_in_time_slot_d' do
      assert_equal 'must be greater than or equal to 0',
                   @daily.errors.on(:average_skew_in_time_slot_d)
    end
    
  end
  
  class WithNonnumericAverageSkewInTimeSlotE < ActiveSupport::TestCase
    
    def setup
      @daily = Daily.new(:average_skew_in_time_slot_e => 'foo')
      @daily.valid?
    end
    
    test 'should have numericality validation error on average_skew_in_time_slot_e' do
      assert_equal 'is not a number',
                   @daily.errors.on(:average_skew_in_time_slot_e)
    end
    
  end
  
  class WithNegativeAverageSkewInTimeSlotE < ActiveSupport::TestCase
    
    def setup
      @daily = Daily.new(:average_skew_in_time_slot_e => -0.1)
      @daily.valid?
    end
    
    test 'should have numericality range validation error on average_skew_in_time_slot_e' do
      assert_equal 'must be greater than or equal to 0',
                   @daily.errors.on(:average_skew_in_time_slot_e)
    end
    
  end
  
  class WithNonnumericAverageSkewInTimeSlotF < ActiveSupport::TestCase
    
    def setup
      @daily = Daily.new(:average_skew_in_time_slot_f => 'foo')
      @daily.valid?
    end
    
    test 'should have numericality validation error on average_skew_in_time_slot_f' do
      assert_equal 'is not a number',
                   @daily.errors.on(:average_skew_in_time_slot_f)
    end
    
  end
  
  class WithNegativeAverageSkewInTimeSlotF < ActiveSupport::TestCase
    
    def setup
      @daily = Daily.new(:average_skew_in_time_slot_f => -0.1)
      @daily.valid?
    end
    
    test 'should have numericality range validation error on average_skew_in_time_slot_f' do
      assert_equal 'must be greater than or equal to 0',
                   @daily.errors.on(:average_skew_in_time_slot_f)
    end
    
  end
  
  class WithLongNotes < ActiveSupport::TestCase
    
    def setup
      @daily = Daily.new(:notes => 'a' * 257)
      @daily.valid?
    end
    
    test 'should have length validation error on value' do
      assert_equal 'is too long (maximum is 255 characters)',
                   @daily.errors.on(:notes)
    end
    
  end
  
  class Protections < ActiveSupport::TestCase
    
    test 'should protect id' do
      assert_nil Daily.new(:id => 123).id
    end
    
    test 'should protect type' do
      assert_equal 'Daily', Daily.new(:type => 'foo').type
    end
    
    test 'should not protect period_ends_on' do
      date = Date.parse('2009-06-10')
      assert_equal date, Daily.new(:period_ends_on => date).period_ends_on
    end
    
    test 'should not protect contains_approximate_times' do
      assert_equal true,
                   Daily.new(:contains_approximate_times => true).contains_approximate_times
      assert_equal false,
                   Daily.new(:contains_approximate_times => false).contains_approximate_times
    end
    
    test 'should not protect average_value' do
      assert_equal 123, Daily.new(:average_value => 123).average_value
    end
    
    test 'should not protect standard_deviation_of_value' do
      assert_equal 50,
                   Daily.new(:standard_deviation_of_value => 50).standard_deviation_of_value
    end
    
    test 'should not protect maximum_value' do
      assert_equal 321, Daily.new(:maximum_value => 321).maximum_value
    end
    
    test 'should not protect minimum_value' do
      assert_equal 21, Daily.new(:minimum_value => 21).minimum_value
    end
    
    test 'should not protect average_skew' do
      assert_equal 0.5, Daily.new(:average_skew => 0.5).average_skew
    end
    
    test 'should not protect average_value_in_time_slot_a' do
      assert_equal 123,
                   Daily.new(:average_value_in_time_slot_a => 123).average_value_in_time_slot_a
    end
    
    test 'should not protect average_value_in_time_slot_b' do
      assert_equal 123,
                   Daily.new(:average_value_in_time_slot_b => 123).average_value_in_time_slot_b
    end
    
    test 'should not protect average_value_in_time_slot_c' do
      assert_equal 123,
                   Daily.new(:average_value_in_time_slot_c => 123).average_value_in_time_slot_c
    end
    
    test 'should not protect average_value_in_time_slot_d' do
      assert_equal 123,
                   Daily.new(:average_value_in_time_slot_d => 123).average_value_in_time_slot_d
    end
    
    test 'should not protect average_value_in_time_slot_e' do
      assert_equal 123,
                   Daily.new(:average_value_in_time_slot_e => 123).average_value_in_time_slot_e
    end
    
    test 'should not protect average_value_in_time_slot_f' do
      assert_equal 123,
                   Daily.new(:average_value_in_time_slot_f => 123).average_value_in_time_slot_f
    end
    
    test 'should not protect average_skew_in_time_slot_a' do
      assert_equal 0.5,
                   Daily.new(:average_skew_in_time_slot_a => 0.5).average_skew_in_time_slot_a
    end
    
    test 'should not protect average_skew_in_time_slot_b' do
      assert_equal 0.5,
                   Daily.new(:average_skew_in_time_slot_b => 0.5).average_skew_in_time_slot_b
    end
    
    test 'should not protect average_skew_in_time_slot_c' do
      assert_equal 0.5,
                   Daily.new(:average_skew_in_time_slot_c => 0.5).average_skew_in_time_slot_c
    end
    
    test 'should not protect average_skew_in_time_slot_d' do
      assert_equal 0.5,
                   Daily.new(:average_skew_in_time_slot_d => 0.5).average_skew_in_time_slot_d
    end
    
    test 'should not protect average_skew_in_time_slot_e' do
      assert_equal 0.5,
                   Daily.new(:average_skew_in_time_slot_e => 0.5).average_skew_in_time_slot_e
    end
    
    test 'should not protect average_skew_in_time_slot_f' do
      assert_equal 0.5,
                   Daily.new(:average_skew_in_time_slot_f => 0.5).average_skew_in_time_slot_f
    end
    
    test 'should not protect notes' do
      assert_equal 'foo', Daily.new(:notes => 'foo').notes
    end
    
    test 'should protect created_at' do
      assert_nil Daily.new(:created_at => '2009-06-10').created_at
    end
    
    test 'should protect updated_at' do
      assert_nil Daily.new(:updated_at => '2009-06-10').updated_at
    end
    
  end
  
  class With3Slots < ActiveSupport::TestCase
    
    def setup
      @daily = Daily.new(:average_value_in_time_slot_b => 100,
                         :average_value_in_time_slot_c => 110,
                         :average_value_in_time_slot_e =>  95,
                         :average_skew_in_time_slot_b => 0.0,
                         :average_skew_in_time_slot_c => 0.05,
                         :average_skew_in_time_slot_e => 0.1)
    end
    
    test 'should return 3 when sent measured_slots_count' do
      assert_equal 3, @daily.measured_slots_count
    end
    
    test 'should return :critical when sent measured_slots_count_severity' do
      assert_equal :critical, @daily.measured_slots_count_severity
    end
    
    test 'should return expected number when sent weighted_average_skew' do
      assert_in_delta 0.05, @daily.weighted_average_skew, 0.000001
    end
    
    test 'should return expected severity when sent weighted_average_skew_severity' do
      assert_nil @daily.weighted_average_skew_severity
    end
    
    test 'should return expected number when sent risk_index' do
      assert_in_delta 0.916667, @daily.risk_index, 0.000001
    end
    
    test 'should return expected severity when sent risk_severity' do
      assert_nil @daily.risk_severity
    end
    
  end
  
  class With4Slots < ActiveSupport::TestCase
    
    def setup
      @daily = Daily.new(:average_value_in_time_slot_b => 100,
                         :average_value_in_time_slot_c => 110,
                         :average_value_in_time_slot_e =>  95,
                         :average_value_in_time_slot_f =>  85,
                         :average_skew_in_time_slot_b => 0.1,
                         :average_skew_in_time_slot_c => 0.2,
                         :average_skew_in_time_slot_e => 0.3,
                         :average_skew_in_time_slot_f => 0.4)
    end
    
    test 'should return 4 when sent measured_slots_count' do
      assert_equal 4, @daily.measured_slots_count
    end
    
    test 'should return :moderate when sent measured_slots_count_severity' do
      assert_equal :moderate, @daily.measured_slots_count_severity
    end
    
    test 'should return expected number when sent weighted_average_skew' do
      assert_equal 0.25, @daily.weighted_average_skew
    end
    
    test 'should return expected severity when sent weighted_average_skew_severity' do
      assert_equal :moderate, @daily.weighted_average_skew_severity
    end
    
    test 'should return expected number when sent risk_index' do
      assert_in_delta 1.583333, @daily.risk_index, 0.000001
    end
    
    test 'should return expected severity when sent risk_severity' do
      assert_equal :moderate, @daily.risk_severity
    end
    
  end
  
  class With5Slots < ActiveSupport::TestCase
    
    def setup
      @daily = Daily.new(:average_value_in_time_slot_b => 100,
                         :average_value_in_time_slot_c => 110,
                         :average_value_in_time_slot_d =>  95,
                         :average_value_in_time_slot_e =>  85,
                         :average_value_in_time_slot_f =>  75,
                         :average_skew_in_time_slot_b => 0.3,
                         :average_skew_in_time_slot_c => 0.4,
                         :average_skew_in_time_slot_d => 0.5,
                         :average_skew_in_time_slot_e => 0.6,
                         :average_skew_in_time_slot_f => 0.7)
    end
    
    test 'should return 5 when sent measured_slots_count' do
      assert_equal 5, @daily.measured_slots_count
    end
    
    test 'should return nil when sent measured_slots_count_severity' do
      assert_nil @daily.measured_slots_count_severity
    end
    
    test 'should return expected number when sent weighted_average_skew' do
      assert_equal 0.5, @daily.weighted_average_skew
    end
    
    test 'should return expected severity when sent weighted_average_skew_severity' do
      assert_equal :critical, @daily.weighted_average_skew_severity
    end
    
    test 'should return expected number when sent risk_index' do
      assert_in_delta 2.5, @daily.risk_index, 0.000001
    end
    
    test 'should return expected severity when sent risk_severity' do
      assert_equal :critical, @daily.risk_severity
    end
    
  end
  
  class RiskGrade < ActiveSupport::TestCase
    
    def setup
      @daily = Daily.new
    end
    
    test 'should return "A+" when sent risk_grade and risk_index is 0.0' do
      @daily.stubs(:risk_index).returns 0.0
      assert_equal 'A+', @daily.risk_grade
    end
    
    test 'should return "A+" when sent risk_grade and risk_index is 0.333332' do
      @daily.stubs(:risk_index).returns 0.333332
      assert_equal 'A+', @daily.risk_grade
    end
    
    test 'should return "A" when sent risk_grade and risk_index is 0.333333' do
      @daily.stubs(:risk_index).returns 0.333333
      assert_equal 'A', @daily.risk_grade
    end
    
    test 'should return "A" when sent risk_grade and risk_index is 0.666666' do
      @daily.stubs(:risk_index).returns 0.666666
      assert_equal 'A', @daily.risk_grade
    end
    
    test 'should return "A-" when sent risk_grade and risk_index is 0.666667' do
      @daily.stubs(:risk_index).returns 0.666667
      assert_equal 'A-', @daily.risk_grade
    end
    
    test 'should return "A-" when sent risk_grade and risk_index is 0.999999' do
      @daily.stubs(:risk_index).returns 0.999999
      assert_equal 'A-', @daily.risk_grade
    end
    
    test 'should return "B+" when sent risk_grade and risk_index is 1.0' do
      @daily.stubs(:risk_index).returns 1.0
      assert_equal 'B+', @daily.risk_grade
    end
    
    test 'should return "B+" when sent risk_grade and risk_index is 1.333332' do
      @daily.stubs(:risk_index).returns 1.333332
      assert_equal 'B+', @daily.risk_grade
    end
    
    test 'should return "B" when sent risk_grade and risk_index is 1.333333' do
      @daily.stubs(:risk_index).returns 1.333333
      assert_equal 'B', @daily.risk_grade
    end
    
    test 'should return "B" when sent risk_grade and risk_index is 1.666666' do
      @daily.stubs(:risk_index).returns 1.666666
      assert_equal 'B', @daily.risk_grade
    end
    
    test 'should return "B-" when sent risk_grade and risk_index is 1.666667' do
      @daily.stubs(:risk_index).returns 1.666667
      assert_equal 'B-', @daily.risk_grade
    end
    
    test 'should return "B-" when sent risk_grade and risk_index is 1.999999' do
      @daily.stubs(:risk_index).returns 1.999999
      assert_equal 'B-', @daily.risk_grade
    end
    
    test 'should return "C+" when sent risk_grade and risk_index is 2.0' do
      @daily.stubs(:risk_index).returns 2.0
      assert_equal 'C+', @daily.risk_grade
    end
    
    test 'should return "C+" when sent risk_grade and risk_index is 2.333332' do
      @daily.stubs(:risk_index).returns 2.333332
      assert_equal 'C+', @daily.risk_grade
    end
    
    test 'should return "C" when sent risk_grade and risk_index is 2.333333' do
      @daily.stubs(:risk_index).returns 2.333333
      assert_equal 'C', @daily.risk_grade
    end
    
    test 'should return "C" when sent risk_grade and risk_index is 2.666666' do
      @daily.stubs(:risk_index).returns 2.666666
      assert_equal 'C', @daily.risk_grade
    end
    
    test 'should return "C-" when sent risk_grade and risk_index is 2.666667' do
      @daily.stubs(:risk_index).returns 2.666667
      assert_equal 'C-', @daily.risk_grade
    end
    
    test 'should return "C-" when sent risk_grade and risk_index is 2.999999' do
      @daily.stubs(:risk_index).returns 2.999999
      assert_equal 'C-', @daily.risk_grade
    end
    
    test 'should return "D+" when sent risk_grade and risk_index is 3.0' do
      @daily.stubs(:risk_index).returns 3.0
      assert_equal 'D+', @daily.risk_grade
    end
    
    test 'should return "D+" when sent risk_grade and risk_index is 3.333332' do
      @daily.stubs(:risk_index).returns 3.333332
      assert_equal 'D+', @daily.risk_grade
    end
    
    test 'should return "D" when sent risk_grade and risk_index is 3.333333' do
      @daily.stubs(:risk_index).returns 3.333333
      assert_equal 'D', @daily.risk_grade
    end
    
    test 'should return "D" when sent risk_grade and risk_index is 3.666666' do
      @daily.stubs(:risk_index).returns 3.666666
      assert_equal 'D', @daily.risk_grade
    end
    
    test 'should return "D-" when sent risk_grade and risk_index is 3.666667' do
      @daily.stubs(:risk_index).returns 3.666667
      assert_equal 'D-', @daily.risk_grade
    end
    
    test 'should return "D-" when sent risk_grade and risk_index is 3.999999' do
      @daily.stubs(:risk_index).returns 3.999999
      assert_equal 'D-', @daily.risk_grade
    end
    
    test 'should return "F" when sent risk_grade and risk_index is 4.0' do
      @daily.stubs(:risk_index).returns 4.0
      assert_equal 'F', @daily.risk_grade
    end
    
  end
  
end

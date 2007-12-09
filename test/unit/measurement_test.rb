require File.dirname(__FILE__) + '/../test_helper'
require 'mocha'

class Measurement; end

module MeasurementTest

  class Validations < ActiveSupport::TestCase
    
    def test_should_validate_presence_of_at_and_value
      Measurement.expects(:validates_presence_of).with :at, :value
      load 'app/models/measurement.rb'
    end
    
  end
  
  class MissingAccountingDateWithMiddayAt < ActiveSupport::TestCase
    
    def setup
      @at_string = '2007-12-09 15:37'
      @measurement = Measurement.new(:at => @at_string,
                                     :value => 100)
      @measurement.save!
    end
    
    def test_should_set_accounting_date_to_at_when_saved
      assert_equal Time.parse(@at_string), @measurement.accounting_date
    end
    
  end
  
  class MissingAccountingDateWithMidnightAt < ActiveSupport::TestCase
    
    def setup
      @measurement = Measurement.new(:at => '2007-12-09 00:44',
                                     :value => 100)
      @measurement.save!
    end
    
    def test_should_set_accounting_date_to_day_before_at_when_saved
      assert_equal Time.parse('2007-12-08 00:44'), @measurement.accounting_date
    end
    
  end

end

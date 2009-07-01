require File.dirname(__FILE__) + '/../test_helper'

module MathTest
  
  class Mean < ActiveSupport::TestCase
    
    test 'should return 2.0 when sent with 2' do
      actual = Math.mean(2)
      assert_equal 2.0, actual
      assert_instance_of Float, actual
    end
    
    test 'should return 2.0 when sent with 2.0' do
      actual = Math.mean(2.0)
      assert_equal 2.0, actual
      assert_instance_of Float, actual
    end
    
    test 'should return 1.5 when sent with 1 and 2' do
      actual = Math.mean(1, 2)
      assert_equal 1.5, actual
      assert_instance_of Float, actual
    end
    
    test 'should return 1.5 when sent with 1.0 and 2.0' do
      actual = Math.mean(1.0, 2.0)
      assert_equal 1.5, actual
      assert_instance_of Float, actual
    end
    
    test 'should return 0.0 when sent with no arguments' do
      actual = Math.mean
      assert_equal 0.0, actual
      assert_instance_of Float, actual
    end
    
  end
  
  class Stddevp < ActiveSupport::TestCase
    
    test 'should return 0.0 when sent with 2' do
      actual = Math.stddevp(2)
      assert_equal 0.0, actual
      assert_instance_of Float, actual
    end
    
    test 'should return 0.0 when sent with 2.0' do
      actual = Math.stddevp(2.0)
      assert_equal 0.0, actual
      assert_instance_of Float, actual
    end
    
    test 'should return 0.5 when sent with 1 and 2' do
      actual = Math.stddevp(1, 2)
      assert_equal 0.5, actual
      assert_instance_of Float, actual
    end
    
    test 'should return 0.5 when sent with 1.0 and 2.0' do
      actual = Math.stddevp(1.0, 2.0)
      assert_equal 0.5, actual
      assert_instance_of Float, actual
    end
    
    test 'should return 0.0 when sent with no arguments' do
      actual = Math.stddevp
      assert_equal 0.0, actual
      assert_instance_of Float, actual
    end
    
  end
  
  class Sum < ActiveSupport::TestCase
    
    test 'should return 2 when sent with 2' do
      actual = Math.sum(2)
      assert_equal 2, actual
      assert_instance_of Fixnum, actual
    end
    
    test 'should return 2.0 when sent with 2.0' do
      actual = Math.sum(2.0)
      assert_equal 2.0, actual
      assert_instance_of Float, actual
    end
    
    test 'should return 3 when sent with 1 and 2' do
      actual = Math.sum(1, 2)
      assert_equal 3, actual
      assert_instance_of Fixnum, actual
    end
    
    test 'should return 3.0 when sent with 1.0 and 2.0' do
      actual = Math.sum(1.0, 2.0)
      assert_equal 3.0, actual
      assert_instance_of Float, actual
    end
    
    test 'should return 0 when sent with no arguments' do
      actual = Math.sum
      assert_equal 0, actual
      assert_instance_of Fixnum, actual
    end
    
  end
  
end

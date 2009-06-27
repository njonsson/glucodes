require File.dirname(__FILE__) + '/../test_helper'

module MathTest
  
  class Mean < ActiveSupport::TestCase
    
    test 'should return 2.0 when sent with 2' do
      assert_equal '2.0', Math.mean(2).to_s
    end
    
    test 'should return 2.0 when sent with 2.0' do
      assert_equal '2.0', Math.mean(2.0).to_s
    end
    
    test 'should return 1.5 when sent with 1 and 2' do
      assert_equal '1.5', Math.mean(1, 2).to_s
    end
    
    test 'should return 1.5 when sent with 1.0 and 2.0' do
      assert_equal '1.5', Math.mean(1.0, 2.0).to_s
    end
    
  end
  
  class Stddevp < ActiveSupport::TestCase
    
    test 'should return 0.0 when sent with 2' do
      assert_equal '0.0', Math.stddevp(2).to_s
    end
    
    test 'should return 0.0 when sent with 2.0' do
      assert_equal '0.0', Math.stddevp(2.0).to_s
    end
    
    test 'should return 0.5 when sent with 1 and 2' do
      assert_equal '0.5', Math.stddevp(1, 2).to_s
    end
    
    test 'should return 0.5 when sent with 1.0 and 2.0' do
      assert_equal '0.5', Math.stddevp(1.0, 2.0).to_s
    end
    
  end
  
  class Sum < ActiveSupport::TestCase
    
    test 'should return 2 when sent with 2' do
      assert_equal '2', Math.sum(2).to_s
    end
    
    test 'should return 2.0 when sent with 2.0' do
      assert_equal '2.0', Math.sum(2.0).to_s
    end
    
    test 'should return 3 when sent with 1 and 2' do
      assert_equal '3', Math.sum(1, 2).to_s
    end
    
    test 'should return 3.0 when sent with 1.0 and 2.0' do
      assert_equal '3.0', Math.sum(1.0, 2.0).to_s
    end
    
  end
  
end

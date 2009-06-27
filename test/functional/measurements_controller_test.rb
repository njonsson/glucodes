require 'test_helper'

class MeasurementsControllerTest < ActionController::TestCase
  
  def setup
    create_measurements! 50
  end
  
  test 'should handle GET index.html as expected' do
    assert_no_difference %w(Measurement.count Aggregate.count) do
      get :index
      assert_template 'index.html.haml'
      assert_equal({}, flash)
      assert_equal Measurement.paginate(:page => 1, :per_page => 20),
                   assigns(:measurements)
    end
  end
  
  test "should handle GET index.html with 'page' parameter as expected" do
    assert_no_difference %w(Measurement.count Aggregate.count) do
      get :index, 'page' => '2'
      assert_template 'index.html.haml'
      assert_equal({}, flash)
      assert_equal Measurement.paginate(:page => 2, :per_page => 20),
                   assigns(:measurements)
    end
  end
  
  test "should handle GET index.html with 'per_page' parameter as expected" do
    assert_no_difference %w(Measurement.count Aggregate.count) do
      get :index, 'per_page' => '2'
      assert_template 'index.html.haml'
      assert_equal({}, flash)
      assert_equal Measurement.paginate(:page => 1, :per_page => 2),
                   assigns(:measurements)
    end
  end
  
  test 'should handle XHR GET index.html as expected' do
    assert_no_difference %w(Measurement.count Aggregate.count) do
      xhr :get, :index
      assert_template '_measurements.html.haml'
      assert_equal({}, flash)
      assert_equal Measurement.paginate(:page => 1, :per_page => 20),
                   assigns(:measurements)
    end
  end
  
  test "should handle XHR GET index.html with 'page' parameter as expected" do
    assert_no_difference %w(Measurement.count Aggregate.count) do
      xhr :get, :index, 'page' => '2'
      assert_template '_measurements.html.haml'
      assert_equal({}, flash)
      assert_equal Measurement.paginate(:page => 2, :per_page => 20),
                   assigns(:measurements)
    end
  end
  
  test "should handle XHR GET index.html with 'per_page' parameter as expected" do
    assert_no_difference %w(Measurement.count Aggregate.count) do
      xhr :get, :index, 'per_page' => '2'
      assert_template '_measurements.html.haml'
      assert_equal({}, flash)
      assert_equal Measurement.paginate(:page => 1, :per_page => 2),
                   assigns(:measurements)
    end
  end
  
end

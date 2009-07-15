require 'test_helper'

class MeasurementsControllerTest < ActionController::TestCase
  
  def setup
    Measurement.stubs(:per_page).returns 1
    create_measurements! 2
  end
  
  test 'should handle GET index.html as expected' do
    assert_no_difference %w(Measurement.count Aggregate.count) do
      get :index
      assert_template 'index.html.haml'
      assert_equal({}, flash)
      assert_equal Measurement.paginate(:page => 1), assigns(:measurements)
    end
  end
  
  test "should handle GET index.html with 'page' parameter as expected" do
    assert_no_difference %w(Measurement.count Aggregate.count) do
      get :index, 'page' => '2'
      assert_template 'index.html.haml'
      assert_equal({}, flash)
      assert_equal Measurement.paginate(:page => 2), assigns(:measurements)
    end
  end
  
  test "should handle GET index.html with 'per_page' parameter as expected" do
    assert_no_difference %w(Measurement.count Aggregate.count) do
      get :index, 'per_page' => '1'
      assert_template 'index.html.haml'
      assert_equal({}, flash)
      assert_equal Measurement.paginate(:page => 1, :per_page => 1),
                   assigns(:measurements)
    end
  end
  
  test 'should handle XHR GET index.html as expected' do
    assert_no_difference %w(Measurement.count Aggregate.count) do
      xhr :get, :index
      assert_template '_measurements.html.haml'
      assert_equal({}, flash)
      assert_equal Measurement.paginate(:page => 1), assigns(:measurements)
    end
  end
  
  test "should handle XHR GET index.html with 'page' parameter as expected" do
    assert_no_difference %w(Measurement.count Aggregate.count) do
      xhr :get, :index, 'page' => '2'
      assert_template '_measurements.html.haml'
      assert_equal({}, flash)
      assert_equal Measurement.paginate(:page => 2), assigns(:measurements)
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
  
  test 'should handle GET summary_by_day.html as expected' do
    assert_no_difference %w(Measurement.count Aggregate.count) do
      get :summary_by_day
      assert_template 'summary_by_day.html.haml'
      assert_equal({}, flash)
      assert_equal Daily.paginate(:page => 1), assigns(:dailies)
    end
  end
  
  test "should handle GET summary_by_day.html with 'page' parameter as expected" do
    assert_no_difference %w(Measurement.count Aggregate.count) do
      get :summary_by_day, 'page' => '2'
      assert_template 'summary_by_day.html.haml'
      assert_equal({}, flash)
      assert_equal Daily.paginate(:page => 2), assigns(:dailies)
    end
  end
  
  test "should handle GET summary_by_day.html with 'per_page' parameter as expected" do
    assert_no_difference %w(Measurement.count Aggregate.count) do
      get :summary_by_day, 'per_page' => '2'
      assert_template 'summary_by_day.html.haml'
      assert_equal({}, flash)
      assert_equal Daily.paginate(:page => 1, :per_page => 2), assigns(:dailies)
    end
  end
  
  test 'should handle XHR GET summary_by_day.html as expected' do
    assert_no_difference %w(Measurement.count Aggregate.count) do
      xhr :get, :summary_by_day
      assert_template '_dailies.html.haml'
      assert_equal({}, flash)
      assert_equal Daily.paginate(:page => 1), assigns(:dailies)
    end
  end
  
  test "should handle XHR GET summary_by_day.html with 'page' parameter as expected" do
    assert_no_difference %w(Measurement.count Aggregate.count) do
      xhr :get, :summary_by_day, 'page' => '2'
      assert_template '_dailies.html.haml'
      assert_equal({}, flash)
      assert_equal Daily.paginate(:page => 2), assigns(:dailies)
    end
  end
  
  test "should handle XHR GET summary_by_day.html with 'per_page' parameter as expected" do
    assert_no_difference %w(Measurement.count Aggregate.count) do
      xhr :get, :summary_by_day, 'per_page' => '2'
      assert_template '_dailies.html.haml'
      assert_equal({}, flash)
      assert_equal Daily.paginate(:page => 1, :per_page => 2), assigns(:dailies)
    end
  end
  
end

require File.dirname(__FILE__) + '/../test_helper'

class MeasurementsControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:measurements)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_measurement
    assert_difference('Measurement.count') do
      post :create, :measurement => { :value => 100 }
    end

    assert_redirected_to measurement_path(assigns(:measurement))
  end

  def test_should_show_measurement
    get :show, :id => 1
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => 1
    assert_response :success
  end

  def test_should_update_measurement
    put :update, :id => 1, :measurement => { }
    assert_redirected_to measurement_path(assigns(:measurement))
  end

  def test_should_destroy_measurement
    assert_difference('Measurement.count', -1) do
      delete :destroy, :id => 1
    end

    assert_redirected_to measurements_path
  end
end

require 'test_helper'

class RideDataControllerTest < ActionController::TestCase
  setup do
    @ride_datum = ride_data(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:ride_data)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create ride_datum" do
    assert_difference('RideDatum.count') do
      post :create, ride_datum: { athlete_id: @ride_datum.athlete_id, average_speed: @ride_datum.average_speed, avg_power: @ride_datum.avg_power, calories: @ride_datum.calories, distance: @ride_datum.distance, location_city: @ride_datum.location_city, max_power: @ride_datum.max_power, max_speed: @ride_datum.max_speed, moving_time: @ride_datum.moving_time, ride_id: @ride_datum.ride_id, start_date: @ride_datum.start_date, total_elevation_gain: @ride_datum.total_elevation_gain, total_work: @ride_datum.total_work, trainer: @ride_datum.trainer }
    end

    assert_redirected_to ride_datum_path(assigns(:ride_datum))
  end

  test "should show ride_datum" do
    get :show, id: @ride_datum
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @ride_datum
    assert_response :success
  end

  test "should update ride_datum" do
    put :update, id: @ride_datum, ride_datum: { athlete_id: @ride_datum.athlete_id, average_speed: @ride_datum.average_speed, avg_power: @ride_datum.avg_power, calories: @ride_datum.calories, distance: @ride_datum.distance, location_city: @ride_datum.location_city, max_power: @ride_datum.max_power, max_speed: @ride_datum.max_speed, moving_time: @ride_datum.moving_time, ride_id: @ride_datum.ride_id, start_date: @ride_datum.start_date, total_elevation_gain: @ride_datum.total_elevation_gain, total_work: @ride_datum.total_work, trainer: @ride_datum.trainer }
    assert_redirected_to ride_datum_path(assigns(:ride_datum))
  end

  test "should destroy ride_datum" do
    assert_difference('RideDatum.count', -1) do
      delete :destroy, id: @ride_datum
    end

    assert_redirected_to ride_data_path
  end
end

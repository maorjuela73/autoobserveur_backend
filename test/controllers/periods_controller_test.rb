require 'test_helper'

class PeriodsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @period = periods(:one)
  end

  test "should get index" do
    get periods_url, as: :json
    assert_response :success
  end

  test "should create period" do
    assert_difference('Period.count') do
      post periods_url, params: { period: { duration: @period.duration, end_date: @period.end_date, is_active: @period.is_active, is_update: @period.is_update, start_date: @period.start_date } }, as: :json
    end

    assert_response 201
  end

  test "should show period" do
    get period_url(@period), as: :json
    assert_response :success
  end

  test "should update period" do
    patch period_url(@period), params: { period: { duration: @period.duration, end_date: @period.end_date, is_active: @period.is_active, is_update: @period.is_update, start_date: @period.start_date } }, as: :json
    assert_response 200
  end

  test "should destroy period" do
    assert_difference('Period.count', -1) do
      delete period_url(@period), as: :json
    end

    assert_response 204
  end
end

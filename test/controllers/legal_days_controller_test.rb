require 'test_helper'

class LegalDaysControllerTest < ActionDispatch::IntegrationTest

  setup do
    @legal_day = legal_days(:one)
    @site = sites(:one)
    @user = users(:one)
    post signin_url, params: { user: { login: @user.login, password: 'secret' } }
  end

  test "should get index" do
    get legal_days_url
    assert_response :success
  end

  test "should get new" do
    get new_legal_day_url
    assert_response :success
  end

  test "should create legal_day" do
    assert_difference('LegalDay.count') do
      post legal_days_url, params: { legal_day: { name: 'Test', 
                                                  site_id: @site_id, 
                                                  start_date: Time::now.to_s(:short_date), 
                                                  year: 2016 } }
    end

    assert_redirected_to legal_days_url
  end

  test "should show legal_day" do
    get legal_day_url(@legal_day)
    assert_response :success
  end

  test "should get edit" do
    get edit_legal_day_url(@legal_day)
    assert_response :success
  end

  test "should update legal_day" do
    patch legal_day_url(@legal_day), params: { legal_day: { name: @legal_day.name, 
                                                            site_id: @legal_day.site_id, 
                                                            start_date: @legal_day.start_date, 
                                                            year: @legal_day.year } }
    assert_redirected_to legal_days_url
  end

  test "should destroy legal_day" do
    assert_difference('LegalDay.count', -1) do
      delete legal_day_url(@legal_day)
    end

    assert_redirected_to legal_days_url
  end
end

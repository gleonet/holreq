require 'test_helper'

class LeavesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @leave = leaves(:one)
    @leave_type = leave_types(:one)
    @user = users(:one)
    post signin_url, params: { user: { login: @user.login, password: 'secret' } }
  end

  test "should get index" do
    get leaves_url
    assert_response :success
  end

  test "should get new" do
    get new_leave_url(user_id: @user.id)
    assert_response :success
  end

  test "should create leave" do
    assert_difference('Leave.count') do
      post leaves_url, params: { leave: { leave_type_id: @leave_type.id, nb_hours: @leave.nb_hours, user_id: @user.id, year: @leave.year } }
    end

    assert_redirected_to user_url(@user)
  end

  test "should show leave" do
    get leave_url(@leave)
    assert_response :success
  end

  test "should get edit" do
    get edit_leave_url(@leave)
    assert_response :success
  end

  test "should update leave" do
    patch leave_url(@leave), params: { leave: { leave_type_id: @leave_type.id, nb_hours: @leave.nb_hours, user_id: @user.id, year: @leave.year } }
    assert_redirected_to leave_url(@leave)
  end

  test "should destroy leave" do
    assert_difference('Leave.count', -1) do
      delete leave_url(@leave)
    end

    assert_redirected_to leaves_url
  end
end

require 'test_helper'

class LeaveRequestsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @leave_request = leave_requests(:one)
    @user = users(:one)
    @site = sites(:one)
    @session_user = users(:one)
    @leave = leaves(:one)
    @leave_type = leave_types(:one)
    post signin_url, params: { user: { login: @user.login, password: 'secret' } }
  end

  test "should get index" do
    get user_leave_requests_url(@user)
    assert_response :success
  end

  test "should get new" do
    get new_user_leave_request_url(@user)
    assert_response :success
  end

  test "should create leave_request" do
    assert_difference('LeaveRequest.count') do
      post user_leave_requests_url(@user), params: { leave_request: { approved_by_id: @leave_request.approved_by_id,
                                                          description: @leave_request.description,
                                                          leave_id: @leave.id,
                                                          leave_type_id: @leave_type.id,
                                                          nb_hours: @leave_request.nb_hours,
                                                          start_date: Time::now.days_since(2),
                                                          end_date: Time::now.days_since(3),
                                                          status: @leave_request.status,
                                                          user_id: @user.id,
                                                          range: @leave_request.range,
                                                          period: @leave_request.period } }
    end

    assert_redirected_to user_url(LeaveRequest.last.user)
  end

  test "should show leave_request" do
    @leave_request.user = @user
    @leave_request.save
    get user_leave_request_path(@user, @leave_request)
    assert_response :success
  end

  test "should get edit" do
    @leave_request.user = @user
    @leave_request.save
    get edit_user_leave_request_path(@user, @leave_request)
    assert_response :success
  end

  test "should update leave_request" do
    @leave.user_id = @user.id
    @leave.leave_type_id = @leave_type.id
    @leave.save
    patch user_leave_request_url(@user, @leave_request), params: { leave_request: { approved_by_id: @leave_request.approved_by_id,
                                                                                    description: @leave_request.description,
                                                                                    leave_id: @leave.id,
                                                                                    leave_type_id: @leave_type.id,
                                                                                    nb_hours: @leave_request.nb_hours,
                                                                                    start_date: 2.days.since.to_datetime,
                                                                                    end_date: 3.days.since.to_datetime,
                                                                                    status: @leave_request.status,
                                                                                    user_id: @user.id,
                                                                                    range: @leave_request.range,
                                                                                    period: @leave_request.period } }
    assert_redirected_to user_leave_request_url(@user, @leave_request)
  end

  test "should destroy leave_request" do
    @leave_request.user = @user
    @leave_request.save
    assert_difference('LeaveRequest.count', -1) do
      delete user_leave_request_url(@user, @leave_request)
    end

    assert_redirected_to user_path(@user)
  end
end

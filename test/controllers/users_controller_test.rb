require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
    @site = sites(:one)
    @team = teams(:one)
    post signin_url, params: { user: { login: @user.login, password: 'secret' } }
  end

  test "should get index" do
    get users_url
    assert_response :success
  end

  test "should get new" do
    get new_user_url
    assert_response :success
  end

  test "should create user" do
    assert_difference('User.count') do
      post users_url, params: { user: { email: @user.email + '3',
                                        external_id: @user.external_id + '3',
                                        firstname: @user.firstname + '3',
                                        lastname: @user.lastname + '3',
                                        login: @user.login + '3',
                                        password: 'secret',
                                        password_confirmation: 'secret',
                                        site_id: @site.id,
                                        enabled: true,
                                        role: @user.role,
                                        team_id: @team.id } }
    end

    assert_redirected_to users_url
  end

  test "should show user" do
    get user_url(@user)
    assert_response :success
  end

  test "should get edit" do
    get edit_user_url(@user)
    assert_response :success
  end

  test "should update user" do
    patch user_url(@user), params: { user: { email: @user.email + '4',
                                             external_id: @user.external_id + '4',
                                             firstname: @user.firstname + '4',
                                             lastname: @user.lastname + '4',
                                             login: @user.login + '4',
                                             password: 'secret',
                                             password_confirmation: 'secret',
                                             site_id: @site.id,
                                             enabled: true,
                                             role: @user.role,
                                             team_id: @team.id } }
    assert_redirected_to users_url
  end

  test "should disable user" do
    delete user_url(@user)
    assert_redirected_to users_url

  end
end

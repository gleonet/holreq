require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test 'Login is mandatory' do
    user = User.new(firstname: 'test', lastname: 'test', email: 'test',
                    password: 'test', password_confirmation: 'test',
                    site: sites(:one), manager: users(:one))
    assert_not user.save
  end

  test 'Login is uniq' do
    user1 = User.new(firstname: 'test', lastname: 'test', email: 'test',
                     password: 'test', password_confirmation: 'test', login: 'test',
                     site: sites(:one), manager: users(:one))
    user1.save
    user2 = User.new(firstname: 'test2', lastname: 'test2', email: 'test2',
                     password: 'test', password_confirmation: 'test', login: 'test',
                     site: sites(:one), manager: users(:one))
    assert_not user2.save
  end
end

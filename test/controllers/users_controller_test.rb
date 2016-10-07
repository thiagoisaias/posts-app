require 'test_helper'
# User Controller tests
class UsersControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:example)
  end

  test 'should get new' do
    get :new
    assert_response :success
  end
end

require 'test_helper'

# test "the truth" do
#   assert true
# end
class UsersEditTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:example)
  end

  test 'unsuccessful edit' do
    get edit_user_path(@user)
    assert_template 'users/edit'
    patch user_path(@user), params: {
      user: {
        name: '',
        email: 'foo@invalid.com',
        password: 'foo',
        password_confirmation: 'bar'
      }
    }
    assert_template 'users/edit'
  end

=begin
  test 'successful edit' do
    get edit_user_path(@user)
    assert_template 'users/edit'
    patch user_path(@user), params: {
      user: {
        name: name,
        email: email,
        password: '',
        password_confirmation: ''
      }
    }
    assert_not flash.empty?
    assert_redirected_to @user
    @user.reload
    assert_equal name, @user.name
    assert_equal email, @user.email
  end
=end
end

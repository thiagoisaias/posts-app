require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
    # test "the truth" do
    #   assert true
    # end

    test 'invalid signup info' do
        get signup_path

        assert_no_difference 'User.count' do
            post users_path, params: { user: { name: '', email: '', password: 'asd', password_confirmation: 'akaka' } }
        end
    end
end

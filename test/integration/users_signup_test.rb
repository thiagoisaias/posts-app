require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
    invalid_params = { params: { user: { name: '', email: '', password: 'asd', password_confirmation: 'akaka' } } }
    test 'invalid signup info' do
        get signup_path

        assert_no_difference 'User.count' do
            post users_path, invalid_params
        end
    end

    test 'valid signup' do
        get signup_path

        assert_difference 'User.count', 1 do
        post users_path, params: { user: { name:  'Example User',
                                            email: 'user@example.com',
                                            password:              'password',
                                            password_confirmation: 'password' } }
        end
        follow_redirect!
        assert_template 'users/show'
        assert is_logged_in?
    end
end

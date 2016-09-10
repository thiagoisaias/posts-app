require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest

    invalid_params = { params: { user: { name: '', email: '', password: 'asd', password_confirmation: 'akaka' } } }
    valid_params = { params: { user: { name: 'example', email: 'example@email.com', password: 'pass123', password_confirmation: 'pass123' } } }

    test 'invalid signup info' do
        get signup_path

        assert_no_difference 'User.count' do
            post users_path, invalid_params
        end
    end

    test 'valid signup' do
        get signup_path

        assert_difference 'User.count', 1 do
            post users_path, valid_params
        end
        follow_redirect!
        assert_template 'users/show'
    end
end

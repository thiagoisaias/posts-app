require 'test_helper'

class UserTest < ActiveSupport::TestCase
    # test "the truth" do
    #   assert true
    # end
    def setup
        @user = User.new(name: 'Example name', email: 'example@email.com',
                         password: 'opaopa', password_confirmation: 'opaopa')
    end

    test 'should be valid' do
        assert @user.valid?
    end

    test 'name should not be blank' do
        @user.name = ' '
        assert_not @user.valid?
    end

    test 'name should not be too long' do
        @user.name = 'a' * 51
        assert_not @user.valid?
    end

    test 'email should not be blank' do
        @user.email = ' '
        assert_not @user.valid?
    end

    test 'email should not be too long' do
        @user.email = 'a' * 256
        assert_not @user.valid?
    end

    test 'email should be valid' do
        valid_addresses = 'user@example.com USER@foo.com user@example.com
            USER@foo.COM A_US-ER@foo.bar.org first.last@foo.jp alice+bob@baz.cn'.split
        valid_addresses.each do |aux|
            @user.email = aux
            assert @user.valid?
        end
    end

    test 'email should not be valid' do
        invalid_adresses = 'asdasd user@example,com user_at_foo.org user.name@example.
                           foo@bar_baz.com foo@bar+baz.com'.split
        invalid_adresses.each do |aux|
            @user.email = aux
            assert_not @user.valid?
        end
    end

    test 'email should be unique' do
        duplicate_user = @user.dup
        duplicate_user.email = @user.email.upcase
        @user.save
        assert_not duplicate_user.valid?
    end

    test 'email should be saved as downcase' do
        upper_case = 'OPA@EMAIL.COM'
        @user.email = upper_case
        @user.save
        assert_equal upper_case.downcase, @user.reload.email
    end

    test 'password should not be blank' do
        @user.password = ' ' * 10
        assert_not @user.valid?
    end

    test 'password should have a minimum length' do
        @user.password = 'a' * 5
        assert_not @user.valid?
    end
end

require 'test_helper'

class MicropostTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  def setup
    @user = users(:example)
    @micropost = @user.microposts.build(content: 'Lorem Ipsum')
  end

  test 'should be valid' do
    assert @micropost.valid?
  end

  test 'user_id should be present' do
    @micropost.user_id = nil
    assert_not @micropost.valid?
    # assert !@micropost.nil?
  end

  test 'content should be present' do
    @micropost.user_id = ' '
    assert_not @micropost.valid?
  end

  test 'content should not exceed 140 characters' do
    @micropost.content = 'a' * 141
    assert_not @micropost.valid?
  end
end

require 'test_helper'

class RelationshipTest < ActiveSupport::TestCase
  def setup
    @relationship = Relationship.new(follower_id: users(:example).id, followed_id: users(:archer).id)
    @example = users(:example)
    @sushi = users(:sushi)
  end

  test 'should be valid' do
    assert @relationship.valid?
  end

  test 'should require a follower id' do
    @relationship.follower_id = nil
    assert_not @relationship.valid?
  end

  test 'should require a followed id' do
    @relationship.followed_id = nil
    assert_not @relationship.valid?
  end

  test 'should follow and then unfollow an user' do
    @example.follow(@sushi)
    assert @example.following?(@sushi)
    assert @sushi.followers.include?(@example)
    @example.unfollow(@sushi)
    assert_not @example.following?(@sushi)
  end
end

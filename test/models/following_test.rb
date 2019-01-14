require 'test_helper'

class FollowingTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  def setup
    @follower = Following.new(follower_id: users(:michael).id, followed_id: users(:archer).id)
  end

  test "should be valid" do
    assert @follower.valid?
  end

  test "should require a follower_id" do
    @follower.follower_id = nil
    assert_not @follower.valid?
  end

  test "should require a followed_id" do
    @follower.followed_id = nil
    assert_not @follower.valid?
  end
end

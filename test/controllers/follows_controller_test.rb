require "test_helper"

class FollowsControllerTest < ActionDispatch::IntegrationTest
  test "should get update" do
    get follows_update_url
    assert_response :success
  end
end

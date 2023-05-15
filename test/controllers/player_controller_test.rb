require "test_helper"

class PlayerControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get player_index_url
    assert_response :success
  end
end

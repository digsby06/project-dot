require 'test_helper'

class TweetsControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get tweets_show_url
    assert_response :success
  end

end

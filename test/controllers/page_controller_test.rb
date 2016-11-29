require 'test_helper'

class PageControllerTest < ActionDispatch::IntegrationTest
  test "should get callback" do
    get page_callback_url
    assert_response :success
  end

end

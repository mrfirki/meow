require 'test_helper'

class TumblrControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get tumblr_index_url
    assert_response :success
  end

end

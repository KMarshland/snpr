require 'test_helper'

class SnpsControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get snps_show_url
    assert_response :success
  end

end

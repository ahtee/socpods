require 'test_helper'

class WelcomeControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:archer)
  end
  
  test "should get index" do
    get root_url
    assert_response :success
  end
end

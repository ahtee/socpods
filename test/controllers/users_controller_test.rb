require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
#   test "should get new" do
#     get users_new_url
#     assert_response :success
#   end
    def setup
        @user = users(:michael)
        @other_user = users(:archer)
    end
  
    test "should redirect edit when not logged in" do
        log_in_as(@other_user)
        get edit_user_path(@user)
        assert_not flash.empty?
        assert_redirected_to root_url
    end

    test "should redirect update when not logged in" do
        log_in_as(@other_user)
        patch user_path(@user), params: { user: { name: @user.username,
                                                email: @user.email } }
        assert_not flash.empty?
        assert_redirected_to root_url
    end

    test "should not allow the admin attribute to be edited via the web" do
        log_in_as(@other_user)
        assert_not @other_user.admin?
        patch user_path(@other_user), params: {
                                        user: { password:              FILL_IN,
                                                password_confirmation: FILL_IN,
                                                admin: FILL_IN } }
        assert_not @other_user.FILL_IN.admin?
      end
end


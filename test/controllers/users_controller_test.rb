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
  
    test "should redirect to root from other user edit when not logged in as username url edit" do
        log_in_as(@other_user)
        get edit_user_path(@user)
        assert flash.empty?
        assert_redirected_to root_url
    end

    test "should redirect update when not logged in as username url edit" do
        log_in_as(@other_user)
        patch user_path(@user), params: { user: { name: @user.username,
                                                email: @user.email } }
        assert flash.empty?
        assert_redirected_to root_url
    end

    test "should not allow the admin attribute to be edited via the web" do
        log_in_as(@other_user)
        assert_not @other_user.admin?
        patch user_path(@other_user), params: {
                                        user: { password: @other_user.password_digest,
                                                password_confirmation: @other_user.password_digest,
                                                admin: 1 } }
        assert_not @other_user.admin?
      end

end


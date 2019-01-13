require 'test_helper'

class UsersProfileTest < ActionDispatch::IntegrationTest

    def setup 
        @user = users(:archer)
        @user_two = users(:michael)
    end

    test "hide new micropost card if profile is not current user" do
        get login_path
        post login_path, params: { session: {   email:    @user.email,
                                                password: 'password' } }
        assert_redirected_to @user
        follow_redirect!
        assert_template 'users/show'
        assert 'shared/new_micropost' # assert new micropost partial exists
        
    end

end
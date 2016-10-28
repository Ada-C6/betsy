require 'test_helper'

class UsersControllerTest < ActionController::TestCase
    def set_auth_hash
      request.env['omniauth.auth'] = OmniAuth.config.mock_auth[:github]
      session[:auth_hash]=request.env['omniauth.auth']
    end

    ### Action: NEW ###
    test "can see the new user registration page if they are a new user" do
      users(:two).destroy #this is to make the user NOT in the database
      set_auth_hash
      get :new
      assert_template 'users/new'
      assert_response :success
    end

     test "get redirected back if they are a current user and logged in" do
      set_auth_hash
      request.env["HTTP_REFERER"]="blah"
      get :new
      assert_redirected_to "blah"
      assert_equal flash[:notice], "You are already registered with github"
    end

     test "get redirected to the auth page if they haven't authorized github yet" do
      get :new
      assert_redirected_to "/auth/github" 
    end

    ### Action: CREATE ###
    test "can create/register a new user" do
      set_auth_hash
      assert_difference('User.count', 1) do
        user_params = {user:{name: "Ada", email: "a@b.com", uid: "12345", provider: "github"}}
        post :create, user_params
        assert_redirected_to index_path
      end
    end

     test "cannot create a new user without email and name" do
      assert_difference('User.count', 0) do
        user_params = {user:{uid: "12345", provider: "github"}}
        post :create, user_params
        assert_equal flash[:notice], "unable to save user"
      end
    end


    ### Action: EDIT ###
    test "should get edit" do
      #user_params = {user:{name: "Ada", email: "a@b.com", uid: "12345", provider: "github"}}
      session[:user_id]= users(:current_user).id
      get :edit, id: users(:current_user)
      assert_response :success
      assert_template 'users/edit'
    end


     ### Action: UPDATE ###
    test "a user can update their account page" do
      #user_params = {user:{name: "Ada", email: "a@b.com", uid: "12345", provider: "github"}}
      @user=users(:current_user)
      session[:user_id]= @user.id
      user_params = {user:{name: "Hello!", email: @user.email, uid: @user.uid, provider: @user.provider}, id: @user.id}
      put :update, user_params
      assert_response :success
    end

    ###LOGGED IN INDEX ###

  test "a user that is not logged in can't see the my account page" do
    request.env["HTTP_REFERER"]="blah"
    get :logged_in_index
    assert_redirected_to "blah"
    assert_equal flash[:notice], "please log in to view your account"
  end

  test "a logged user can see the my account page" do
    @user=users(:current_user)
    session[:user_id]= @user.id
    get :logged_in_index
    assert_response :success
  end
  # test "should get new" do
  #   get :new
  #   assert_response :success
  # end

  # test "should get create" do
  #   get :create
  #   assert_response :success
  # end

  

  # test "should get update" do
  #   get :update
  #   assert_response :success
  # end

  # test "should get destroy" do
  #   get :destroy
  #   assert_response :success
  # end

end

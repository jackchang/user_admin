require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  setup do
    @user = users(:one)
    @roles = Role.all
  end

  test "routes grid_update" do
    assert_routing({path: "/users/grid_update", method: "post"}, 
                   { controller: "users", action: "grid_update", })
  end
 
  test "should get index in json" do
    get :index, format: :json
    assert_response :success
    assert_not_nil assigns(:users)
    json = JSON.parse @response.body
    assert_equal json["records"], assigns(:users).size
  end

  test "should do filer on equal" do
    str = "foo"
    field = "user_name"
    get :index, _search: "true", searchOper: "eq", searchField: field, searchString: str, format: :json
    assert_response :success
    json = JSON.parse @response.body    
    assert_equal json["records"], assigns(:users).size
    assert_equal "foo",  assigns(:users)[0].user_name
  end

  test "should do filer on like" do
    str = "fo"
    field = "user_name"
    get :index, _search: "true", searchOper: "cn", searchField: field, searchString: str, format: :json
    assert_response :success
    json = JSON.parse @response.body    
    assert_equal json["records"], assigns(:users).size
    assert_equal "foo",  assigns(:users)[0].user_name
  end

  test "should delete user from jqgrid" do
    assert_difference('User.count', -1 ) do
      post :grid_update, id: @user, oper: "del" , format: :json
    end
    assert_response :success
  end

  test "should not delete user from jqgrid if no 'del' param" do
    assert_difference('User.count', 0 ) do
      post :grid_update, id: @user, oper: "xyz" , format: :json
    end
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create user" do
    @user.user_name = "new user"
    assert_difference('User.count',1) do
      post :create, user: { email: @user.email, first_name: @user.first_name, last_name: @user.last_name, role_names: @user.roles, user_name: @user.user_name }
    end
    assert_redirected_to user_path(assigns(:user))
  end

  test "should show user" do
    get :show, id: @user
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @user
    assert_response :success
  end

  test "should update user" do
    put :update, id: @user, user: { email: @user.email, first_name: @user.first_name, last_name: @user.last_name, role_names: @user.roles, user_name: @user.user_name }
    assert_redirected_to user_path(assigns(:user))
  end

  test "should destroy user" do
    assert_difference('User.count', -1) do
      delete :destroy, id: @user
    end

    assert_redirected_to users_path
  end
end

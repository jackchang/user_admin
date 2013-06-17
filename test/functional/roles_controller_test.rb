require 'test_helper'

class RolesControllerTest < ActionController::TestCase
  setup do
    @role = roles(:one)
    @user = users(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:roles)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create role" do
    new = Role.new( name: 'foo', description: 'bar')
    assert_difference('Role.count') do
      post :create, role: { name: new.name, description: new.description }
    end

    assert_redirected_to role_path(assigns(:role))
  end

  test "should show role" do
    get :show, id: @role
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @role
    assert_response :success
  end

  test "should update role" do
    put :update, id: @role, role: { name: @role.name }
    assert_redirected_to role_path(assigns(:role))
  end

  test "should delete role and user should no longer have the deleted role" do
    assert @user.roles.include?(@role)

    assert_difference('Role.count', -1) do
      delete :destroy, id: @role
    end

    @user.reload
    assert !@user.roles.include?(@role)
    assert !@user.role_names.include?(@role.name)
    assert_redirected_to roles_path
  end
end

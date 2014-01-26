require 'test_helper'

class BhccAccessesControllerTest < ActionController::TestCase
  setup do
    @bhcc_access = bhcc_accesses(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:bhcc_accesses)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create bhcc_access" do
    assert_difference('BhccAccess.count') do
      post :create, bhcc_access: { token: @bhcc_access.token }
    end

    assert_redirected_to bhcc_access_path(assigns(:bhcc_access))
  end

  test "should show bhcc_access" do
    get :show, id: @bhcc_access
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @bhcc_access
    assert_response :success
  end

  test "should update bhcc_access" do
    put :update, id: @bhcc_access, bhcc_access: { token: @bhcc_access.token }
    assert_redirected_to bhcc_access_path(assigns(:bhcc_access))
  end

  test "should destroy bhcc_access" do
    assert_difference('BhccAccess.count', -1) do
      delete :destroy, id: @bhcc_access
    end

    assert_redirected_to bhcc_accesses_path
  end
end

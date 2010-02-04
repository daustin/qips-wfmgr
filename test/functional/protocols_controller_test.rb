require 'test_helper'

class ProtocolsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:protocols)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create protocol" do
    assert_difference('Protocol.count') do
      post :create, :protocol => { }
    end

    assert_redirected_to protocol_path(assigns(:protocol))
  end

  test "should show protocol" do
    get :show, :id => protocols(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => protocols(:one).to_param
    assert_response :success
  end

  test "should update protocol" do
    put :update, :id => protocols(:one).to_param, :protocol => { }
    assert_redirected_to protocol_path(assigns(:protocol))
  end

  test "should destroy protocol" do
    assert_difference('Protocol.count', -1) do
      delete :destroy, :id => protocols(:one).to_param
    end

    assert_redirected_to protocols_path
  end
end

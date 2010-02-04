require 'test_helper'

class StagesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:stages)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create stage" do
    assert_difference('Stage.count') do
      post :create, :stage => { }
    end

    assert_redirected_to stage_path(assigns(:stage))
  end

  test "should show stage" do
    get :show, :id => stages(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => stages(:one).to_param
    assert_response :success
  end

  test "should update stage" do
    put :update, :id => stages(:one).to_param, :stage => { }
    assert_redirected_to stage_path(assigns(:stage))
  end

  test "should destroy stage" do
    assert_difference('Stage.count', -1) do
      delete :destroy, :id => stages(:one).to_param
    end

    assert_redirected_to stages_path
  end
end

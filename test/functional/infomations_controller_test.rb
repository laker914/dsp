require 'test_helper'

class InfomationsControllerTest < ActionController::TestCase
  setup do
    @infomation = infomations(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:infomations)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create infomation" do
    assert_difference('Infomation.count') do
      post :create, :infomation => @infomation.attributes
    end

    assert_redirected_to infomation_path(assigns(:infomation))
  end

  test "should show infomation" do
    get :show, :id => @infomation.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @infomation.to_param
    assert_response :success
  end

  test "should update infomation" do
    put :update, :id => @infomation.to_param, :infomation => @infomation.attributes
    assert_redirected_to infomation_path(assigns(:infomation))
  end

  test "should destroy infomation" do
    assert_difference('Infomation.count', -1) do
      delete :destroy, :id => @infomation.to_param
    end

    assert_redirected_to infomations_path
  end
end

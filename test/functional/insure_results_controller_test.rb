require 'test_helper'

class InsureResultsControllerTest < ActionController::TestCase
  setup do
    @insure_result = insure_results(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:insure_results)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create insure_result" do
    assert_difference('InsureResult.count') do
      post :create, :insure_result => @insure_result.attributes
    end

    assert_redirected_to insure_result_path(assigns(:insure_result))
  end

  test "should show insure_result" do
    get :show, :id => @insure_result.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @insure_result.to_param
    assert_response :success
  end

  test "should update insure_result" do
    put :update, :id => @insure_result.to_param, :insure_result => @insure_result.attributes
    assert_redirected_to insure_result_path(assigns(:insure_result))
  end

  test "should destroy insure_result" do
    assert_difference('InsureResult.count', -1) do
      delete :destroy, :id => @insure_result.to_param
    end

    assert_redirected_to insure_results_path
  end
end

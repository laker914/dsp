require 'test_helper'

class InsureResultsSubsControllerTest < ActionController::TestCase
  setup do
    @insure_results_sub = insure_results_subs(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:insure_results_subs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create insure_results_sub" do
    assert_difference('InsureResultsSub.count') do
      post :create, :insure_results_sub => @insure_results_sub.attributes
    end

    assert_redirected_to insure_results_sub_path(assigns(:insure_results_sub))
  end

  test "should show insure_results_sub" do
    get :show, :id => @insure_results_sub.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @insure_results_sub.to_param
    assert_response :success
  end

  test "should update insure_results_sub" do
    put :update, :id => @insure_results_sub.to_param, :insure_results_sub => @insure_results_sub.attributes
    assert_redirected_to insure_results_sub_path(assigns(:insure_results_sub))
  end

  test "should destroy insure_results_sub" do
    assert_difference('InsureResultsSub.count', -1) do
      delete :destroy, :id => @insure_results_sub.to_param
    end

    assert_redirected_to insure_results_subs_path
  end
end

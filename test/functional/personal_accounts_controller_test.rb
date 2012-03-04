require 'test_helper'

class PersonalAccountsControllerTest < ActionController::TestCase
  setup do
    @personal_account = personal_accounts(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:personal_accounts)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create personal_account" do
    assert_difference('PersonalAccount.count') do
      post :create, :personal_account => @personal_account.attributes
    end

    assert_redirected_to personal_account_path(assigns(:personal_account))
  end

  test "should show personal_account" do
    get :show, :id => @personal_account.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @personal_account.to_param
    assert_response :success
  end

  test "should update personal_account" do
    put :update, :id => @personal_account.to_param, :personal_account => @personal_account.attributes
    assert_redirected_to personal_account_path(assigns(:personal_account))
  end

  test "should destroy personal_account" do
    assert_difference('PersonalAccount.count', -1) do
      delete :destroy, :id => @personal_account.to_param
    end

    assert_redirected_to personal_accounts_path
  end
end

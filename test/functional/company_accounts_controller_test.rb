require 'test_helper'

class CompanyAccountsControllerTest < ActionController::TestCase
  setup do
    @company_account = company_accounts(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:company_accounts)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create company_account" do
    assert_difference('CompanyAccount.count') do
      post :create, :company_account => @company_account.attributes
    end

    assert_redirected_to company_account_path(assigns(:company_account))
  end

  test "should show company_account" do
    get :show, :id => @company_account.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @company_account.to_param
    assert_response :success
  end

  test "should update company_account" do
    put :update, :id => @company_account.to_param, :company_account => @company_account.attributes
    assert_redirected_to company_account_path(assigns(:company_account))
  end

  test "should destroy company_account" do
    assert_difference('CompanyAccount.count', -1) do
      delete :destroy, :id => @company_account.to_param
    end

    assert_redirected_to company_accounts_path
  end
end

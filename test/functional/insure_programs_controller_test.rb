require 'test_helper'

class InsureProgramsControllerTest < ActionController::TestCase
  setup do
    @insure_program = insure_programs(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:insure_programs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create insure_program" do
    assert_difference('InsureProgram.count') do
      post :create, :insure_program => @insure_program.attributes
    end

    assert_redirected_to insure_program_path(assigns(:insure_program))
  end

  test "should show insure_program" do
    get :show, :id => @insure_program.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @insure_program.to_param
    assert_response :success
  end

  test "should update insure_program" do
    put :update, :id => @insure_program.to_param, :insure_program => @insure_program.attributes
    assert_redirected_to insure_program_path(assigns(:insure_program))
  end

  test "should destroy insure_program" do
    assert_difference('InsureProgram.count', -1) do
      delete :destroy, :id => @insure_program.to_param
    end

    assert_redirected_to insure_programs_path
  end
end

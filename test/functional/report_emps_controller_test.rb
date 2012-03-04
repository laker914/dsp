require 'test_helper'

class ReportEmpsControllerTest < ActionController::TestCase
  test "should get query" do
    get :query
    assert_response :success
  end

  test "should get submit" do
    get :submit
    assert_response :success
  end

end

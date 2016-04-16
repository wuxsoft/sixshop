require 'test_helper'

class Admin::RoleControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_role_index_url
    assert_response :success
  end

  test "should get new" do
    get admin_role_new_url
    assert_response :success
  end

  test "should get show" do
    get admin_role_show_url
    assert_response :success
  end

  test "should get edit" do
    get admin_role_edit_url
    assert_response :success
  end

end

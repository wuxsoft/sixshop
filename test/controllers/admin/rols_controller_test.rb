require 'test_helper'

class Admin::RolsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_rols_index_url
    assert_response :success
  end

  test "should get new" do
    get admin_rols_new_url
    assert_response :success
  end

  test "should get destory" do
    get admin_rols_destory_url
    assert_response :success
  end

end

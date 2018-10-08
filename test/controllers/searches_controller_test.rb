require 'test_helper'

class SearchesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get searches_index_url
    assert_response :success
  end

  test "should get show" do
    get searches_show_url
    assert_response :success
  end

  test "should get new" do
    get searches_new_url
    assert_response :success
  end

  test "should get create" do
    get searches_create_url
    assert_response :success
  end

  test "should get edit" do
    get searches_edit_url
    assert_response :success
  end

  test "should get update" do
    get searches_update_url
    assert_response :success
  end

  test "should get delete" do
    get searches_delete_url
    assert_response :success
  end

end

require "test_helper"

class BacklinksControllerTest < ActionDispatch::IntegrationTest
  setup do
    @backlink = backlinks(:one)
  end

  test "should get index" do
    get backlinks_url
    assert_response :success
  end

  test "should get new" do
    get new_backlink_url
    assert_response :success
  end

  test "should create backlink" do
    assert_difference("Backlink.count") do
      post backlinks_url, params: { backlink: {  } }
    end

    assert_redirected_to backlink_url(Backlink.last)
  end

  test "should show backlink" do
    get backlink_url(@backlink)
    assert_response :success
  end

  test "should get edit" do
    get edit_backlink_url(@backlink)
    assert_response :success
  end

  test "should update backlink" do
    patch backlink_url(@backlink), params: { backlink: {  } }
    assert_redirected_to backlink_url(@backlink)
  end

  test "should destroy backlink" do
    assert_difference("Backlink.count", -1) do
      delete backlink_url(@backlink)
    end

    assert_redirected_to backlinks_url
  end
end

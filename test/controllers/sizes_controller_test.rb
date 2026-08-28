require "test_helper"

class SizesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @size = sizes(:one)
  end

  test "should get index" do
    get admin_sizes_url
    assert_response :success
  end

  test "should get new" do
    get new_admin_size_url
    assert_response :success
  end

  test "should create size" do
    assert_difference("Size.count") do
      post admin_sizes_url, params: { size: { size: @size.size } }
    end

    assert_redirected_to admin_size_url(Size.last)
  end

  test "should show size" do
    get admin_size_url(@size)
    assert_response :success
  end

  test "should get edit" do
    get edit_admin_size_url(@size)
    assert_response :success
  end

  test "should update size" do
    patch admin_size_url(@size), params: { size: { size: @size.size } }
    assert_redirected_to admin_size_url(@size)
  end

  test "should destroy size" do
    assert_difference("Size.count", -1) do
      delete admin_size_url(@size)
    end

    assert_redirected_to admin_sizes_url
  end
end

require "test_helper"

class ProductKindsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @product_kind = product_kinds(:one)
  end

  test "should get index" do
    get product_kinds_url
    assert_response :success
  end

  test "should get new" do
    get new_product_kind_url
    assert_response :success
  end

  test "should create product_kind" do
    assert_difference("ProductKind.count") do
      post product_kinds_url, params: { product_kind: { description: @product_kind.description, material: @product_kind.material, name: @product_kind.name } }
    end

    assert_redirected_to product_kind_url(ProductKind.last)
  end

  test "should show product_kind" do
    get product_kind_url(@product_kind)
    assert_response :success
  end

  test "should get edit" do
    get edit_product_kind_url(@product_kind)
    assert_response :success
  end

  test "should update product_kind" do
    patch product_kind_url(@product_kind), params: { product_kind: { description: @product_kind.description, material: @product_kind.material, name: @product_kind.name } }
    assert_redirected_to product_kind_url(@product_kind)
  end

  test "should destroy product_kind" do
    assert_difference("ProductKind.count", -1) do
      delete product_kind_url(@product_kind)
    end

    assert_redirected_to product_kinds_url
  end
end

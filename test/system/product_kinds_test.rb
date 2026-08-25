require "application_system_test_case"

class ProductKindsTest < ApplicationSystemTestCase
  setup do
    @product_kind = product_kinds(:one)
  end

  test "visiting the index" do
    visit product_kinds_url
    assert_selector "h1", text: "Product kinds"
  end

  test "should create product kind" do
    visit product_kinds_url
    click_on "New product kind"

    fill_in "Description", with: @product_kind.description
    fill_in "Material", with: @product_kind.material
    fill_in "Name", with: @product_kind.name
    click_on "Create Product kind"

    assert_text "Product kind was successfully created"
    click_on "Back"
  end

  test "should update Product kind" do
    visit product_kind_url(@product_kind)
    click_on "Edit this product kind", match: :first

    fill_in "Description", with: @product_kind.description
    fill_in "Material", with: @product_kind.material
    fill_in "Name", with: @product_kind.name
    click_on "Update Product kind"

    assert_text "Product kind was successfully updated"
    click_on "Back"
  end

  test "should destroy Product kind" do
    visit product_kind_url(@product_kind)
    click_on "Destroy this product kind", match: :first

    assert_text "Product kind was successfully destroyed"
  end
end

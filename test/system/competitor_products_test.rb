require "application_system_test_case"

class CompetitorProductsTest < ApplicationSystemTestCase
  setup do
    @competitor_product = competitor_products(:one)
  end

  test "visiting the index" do
    visit competitor_products_url
    assert_selector "h1", text: "Competitor products"
  end

  test "should create competitor product" do
    visit competitor_products_url
    click_on "New competitor product"

    fill_in "Asin", with: @competitor_product.asin
    fill_in "Last checked at", with: @competitor_product.last_checked_at
    fill_in "Latest price", with: @competitor_product.latest_price
    fill_in "Latest rating", with: @competitor_product.latest_rating
    fill_in "Name", with: @competitor_product.name
    fill_in "Platform", with: @competitor_product.platform
    fill_in "Product", with: @competitor_product.product_id
    click_on "Create Competitor product"

    assert_text "Competitor product was successfully created"
    click_on "Back"
  end

  test "should update Competitor product" do
    visit competitor_product_url(@competitor_product)
    click_on "Edit this competitor product", match: :first

    fill_in "Asin", with: @competitor_product.asin
    fill_in "Last checked at", with: @competitor_product.last_checked_at.to_s
    fill_in "Latest price", with: @competitor_product.latest_price
    fill_in "Latest rating", with: @competitor_product.latest_rating
    fill_in "Name", with: @competitor_product.name
    fill_in "Platform", with: @competitor_product.platform
    fill_in "Product", with: @competitor_product.product_id
    click_on "Update Competitor product"

    assert_text "Competitor product was successfully updated"
    click_on "Back"
  end

  test "should destroy Competitor product" do
    visit competitor_product_url(@competitor_product)
    click_on "Destroy this competitor product", match: :first

    assert_text "Competitor product was successfully destroyed"
  end
end

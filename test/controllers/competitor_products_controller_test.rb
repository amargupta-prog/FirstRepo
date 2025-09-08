require "test_helper"

class CompetitorProductsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @competitor_product = competitor_products(:one)
  end

  test "should get index" do
    get competitor_products_url
    assert_response :success
  end

  test "should get new" do
    get new_competitor_product_url
    assert_response :success
  end

  test "should create competitor_product" do
    assert_difference("CompetitorProduct.count") do
      post competitor_products_url, params: { competitor_product: { asin: @competitor_product.asin, last_checked_at: @competitor_product.last_checked_at, latest_price: @competitor_product.latest_price, latest_rating: @competitor_product.latest_rating, name: @competitor_product.name, platform: @competitor_product.platform, product_id: @competitor_product.product_id } }
    end

    assert_redirected_to competitor_product_url(CompetitorProduct.last)
  end

  test "should show competitor_product" do
    get competitor_product_url(@competitor_product)
    assert_response :success
  end

  test "should get edit" do
    get edit_competitor_product_url(@competitor_product)
    assert_response :success
  end

  test "should update competitor_product" do
    patch competitor_product_url(@competitor_product), params: { competitor_product: { asin: @competitor_product.asin, last_checked_at: @competitor_product.last_checked_at, latest_price: @competitor_product.latest_price, latest_rating: @competitor_product.latest_rating, name: @competitor_product.name, platform: @competitor_product.platform, product_id: @competitor_product.product_id } }
    assert_redirected_to competitor_product_url(@competitor_product)
  end

  test "should destroy competitor_product" do
    assert_difference("CompetitorProduct.count", -1) do
      delete competitor_product_url(@competitor_product)
    end

    assert_redirected_to competitor_products_url
  end
end

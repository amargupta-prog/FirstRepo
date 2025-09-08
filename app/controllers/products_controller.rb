class ProductsController < ApplicationController
  def index
    @products = Product.includes(:competitor_product).order(:title)
  end

  def show
    @product = Product.includes(:competitor_product).find(params[:id])
  end

  def import_feed
    if params[:feed_url].present?
      body = HTTP.get(params[:feed_url]).to_s  #returns the response body as a string.
      importer = GoogleMerchantFeedImporter.new(StringIO.new(body))
      importer.call
    elseif params[:feed_file].present?
      importer = GoogleMerchantFeedImporter.new(params[:feed_file].tempfile)
      importer.call
    else
      redirect_to products_path, alert: "Please provide a feed URL or upload a feed file." and return
    end

    redirect_to products_path, notice: "Feed imported successfully."
  rescue => e
    redirect_to products_path, alert: "Failed to import feed: #{e.message}"
  end       

  def refresh_competitors
    product = Product.find(params[:id])
    product.competitor_product.find_each do |competitor|
      FetchCompetitorDataJob.perform_later(competitor.id)
    end
    redirect_to product_path(params[:id]), notice: "Refreshing competitor data in background."
  end
end
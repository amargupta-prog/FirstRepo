class ProductsController < ApplicationController
  def index
    @products = Product.includes(:competitor_products).order(:title)
  end

  def show
    @product = Product.includes(:competitor_products).find(params[:id])
  end

  def import_feed
    # If someone opens this URL in browser (GET) — redirect to index where the Import form lives
    # if request.get?
    #   redirect_to products_path and return
    # end

    if params[:feed_url].present?
      body = HTTP.get(params[:feed_url]).to_s    #returns the response body as a string.
      importer = GoogleMerchantFeedImporter.new(StringIO.new(body))
      importer.call
    elsif params[:feed_file].present?
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
    product.competitor_products.find_each do |comp|
      FetchCompetitorDataJob.perform_later(comp.id)
    end
    redirect_to product_path(product), notice: "Refreshing competitor data in background."
  end
end
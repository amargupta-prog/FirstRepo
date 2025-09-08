class CompetitorProductsController < ApplicationController
  before_action :set_product

  def create
    # Creates a new competitor product linked to the current product.
    # example: /products/5/competitor_products will attach the new competitor to Product ID 5.
    # rails automatically sets competitor_products.product_id = @product.id.
    # The values in competitor_params (like name, platform, asin, etc.) are inserted into the competitor_products table.
    @competitor = @product.competitor_products.create!(competitor_params)
    redirect_to product_path(@product), notice: 'Competitor added'
  rescue ActiveRecord::RecordInvalid => e
    redirect_to product_path(@product), alert: e.message
  end


  def update
    @competitor = @product.competitor_products.find(params[:id])
    @competitor.update!(competitor_params)
    # If ASIN supplied, fetch now
    if @competitor.asin.present?
      FetchCompetitorDataJob.perform_later(@competitor.id)
    end
    redirect_to product_path(@product), notice: 'Competitor updated'
  rescue ActiveRecord::RecordInvalid => e
    redirect_to product_path(@product), alert: e.message
  end


  def destroy
    @product.competitor_products.find(params[:id]).destroy
    redirect_to product_path(@product), notice: 'Competitor removed'
  end

  private

  def set_product
    @product = Product.find(params[:product_id])
  end

  def competitor_params
    params.require(:competitor_product).permit(:name, :asin, :platform)
  end
end

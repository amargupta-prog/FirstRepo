class DashboardController < ApplicationController
  def index
    @products = Product.includes(:competitor_products).order(:title)
  end
end

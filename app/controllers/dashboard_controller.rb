class DashboardController < ApplicationController
  def index
    @products = Product.includes(:competitor_product).order(:title)
  end
end

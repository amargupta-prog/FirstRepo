class CompetitorProductsController < ApplicationController
  before_action :set_competitor_product, only: %i[ show edit update destroy ]

  # GET /competitor_products or /competitor_products.json
  def index
    @competitor_products = CompetitorProduct.all
  end

  # GET /competitor_products/1 or /competitor_products/1.json
  def show
  end

  # GET /competitor_products/new
  def new
    @competitor_product = CompetitorProduct.new
  end

  # GET /competitor_products/1/edit
  def edit
  end

  # POST /competitor_products or /competitor_products.json
  def create
    @competitor_product = CompetitorProduct.new(competitor_product_params)

    respond_to do |format|
      if @competitor_product.save
        format.html { redirect_to @competitor_product, notice: "Competitor product was successfully created." }
        format.json { render :show, status: :created, location: @competitor_product }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @competitor_product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /competitor_products/1 or /competitor_products/1.json
  def update
    respond_to do |format|
      if @competitor_product.update(competitor_product_params)
        format.html { redirect_to @competitor_product, notice: "Competitor product was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @competitor_product }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @competitor_product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /competitor_products/1 or /competitor_products/1.json
  def destroy
    @competitor_product.destroy!

    respond_to do |format|
      format.html { redirect_to competitor_products_path, notice: "Competitor product was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_competitor_product
      @competitor_product = CompetitorProduct.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def competitor_product_params
      params.require(:competitor_product).permit(:product_id, :name, :platform, :asin, :latest_price, :latest_rating, :last_checked_at)
    end
end

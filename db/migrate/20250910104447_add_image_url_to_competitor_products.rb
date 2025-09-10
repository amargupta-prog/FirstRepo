class AddImageUrlToCompetitorProducts < ActiveRecord::Migration[7.1]
  def change
    add_column :competitor_products, :image_url, :string
  end
end

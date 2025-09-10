class AddFeedFieldsToProducts < ActiveRecord::Migration[7.1]
  def change
    add_column :products, :description, :text
    add_column :products, :google_product_category, :string
    add_column :products, :product_type, :string
    add_column :products, :condition, :string
    add_column :products, :availability, :string
    add_column :products, :sale_price, :decimal
    add_column :products, :sale_price_effective_date, :string
    add_column :products, :shipping, :text
    add_column :products, :additional_image_links, :jsonb
  end
end

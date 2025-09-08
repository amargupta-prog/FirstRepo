class CreateProducts < ActiveRecord::Migration[7.1]
  def change
    create_table :products do |t|
      t.string :merchant_id
      t.string :title
      t.decimal :price
      t.string :currency
      t.string :brand
      t.string :gtin
      t.string :mpn
      t.string :link
      t.string :image_link
      t.text :icp

      t.timestamps
    end
  end
end

# id | merchant_id | title       | price | currency | brand | gtin | mpn | link | image_link | icp | created_at | updated_at
# ---+-------------+-------------+-------+----------+-------+------+-----+------+-------------+-----+------------+-----------

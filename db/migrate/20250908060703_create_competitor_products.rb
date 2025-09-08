class CreateCompetitorProducts < ActiveRecord::Migration[7.1]
  def change
    create_table :competitor_products do |t|
      t.references :product, null: false, foreign_key: true
      t.string :name
      t.string :platform
      t.string :asin
      t.decimal :latest_price
      t.decimal :latest_rating
      t.datetime :last_checked_at

      t.timestamps
    end
  end
end

# id | product_id | name        | platform | asin       | latest_price | latest_rating | last_checked_at | created_at | updated_at
# ---+------------+-------------+----------+------------+--------------+---------------+-----------------+------------+-----------

#roduct_id  -> products.id (foreign key)
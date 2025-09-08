class CreateCompetitorSnapshots < ActiveRecord::Migration[7.1]
  def change
    create_table :competitor_snapshots do |t|
      t.references :competitor_product, null: false, foreign_key: true
      t.decimal :price
      t.decimal :rating
      t.datetime :captured_at

      t.timestamps
    end
  end
end

# id | competitor_product_id | price | rating | captured_at | created_at | updated_at
# ---+-----------------------+-------+--------+-------------+------------+-----------

class CreateCompetitorSnapshots < ActiveRecord::Migration[7.2]
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

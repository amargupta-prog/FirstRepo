class AddAmazonsChoiceToCompetitorProducts < ActiveRecord::Migration[7.1]
  def change
    add_column :competitor_products, :amazons_choice, :boolean
  end
end

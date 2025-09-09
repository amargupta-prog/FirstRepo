# app/models/product.rb
class Product < ApplicationRecord
  # products have many competitor products
  has_many :competitor_products, dependent: :destroy
  validates :title, presence: true
end
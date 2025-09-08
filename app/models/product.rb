# app/models/product.rb
class Product < ApplicationRecord
    has_many :competitor_product, dependent: :destroy
    validates :title, presence: true
end



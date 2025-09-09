# app/models/competitor_snapshot.rb
class CompetitorSnapshot < ApplicationRecord
  belongs_to :competitor_product
  validates :captured_at, presence: true
end

# app/models/competitor_product.rb
class CompetitorProduct < ApplicationRecord
  belongs_to :product
  has_many :competitor_snapshots, dependent: :destroy

  # Helper: last 4 snapshots ordered by time
  def latest_price(limit = 7)
    competitor_snapshots.order(captured_at: :desc).limit(limit).pluck(:price)
  end

  validates :name, presence: true
  validates :asin, format: { with: /\A[A-Z0-9]{10}\z/, message: "must be a 10-char ASIN" }, allow_blank: true, allow_nil: true

  scope :with_asin, -> { where.not(asin: [nil, ""]) }
end

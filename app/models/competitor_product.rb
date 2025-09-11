# app/models/competitor_product.rb
class CompetitorProduct < ApplicationRecord
  belongs_to :product
  has_many :competitor_snapshots, dependent: :destroy

  # Get only the most recent price
  def latest_price_value
    competitor_snapshots.order(captured_at: :desc).limit(1).pluck(:price).first
  end

  # If you still want last N prices for charts
  def last_prices(limit = 10)
    competitor_snapshots.order(captured_at: :desc).limit(limit).pluck(:price)
  end

  validates :name, presence: true
  validates :asin, format: { with: /\A[A-Z0-9]{10}\z/, message: "must be a 10-char ASIN" }, allow_blank: true, allow_nil: true

  scope :with_asin, -> { where.not(asin: [nil, ""]) }
end

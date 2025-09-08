class CompetitorProduct < ApplicationRecord
  belongs_to :product     #Each CompetitorProduct must be linked to a Product
  has_many :competitor_snapshots, dependent: :destroy

  validates :name, presence: true
  # Validates the format of the ASIN (Amazon’s 10-character product ID).
  validates :asin, format: {with: /\A[B0-9]{10}\z/, message: "must be a valid ASIN"}, allow_nil: true

  scope :with_asin, -> { where.not(asin: [nil, ""]) }
end

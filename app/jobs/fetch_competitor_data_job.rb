class FetchCompetitorDataJob < ApplicationJob
  queue_as :default

  def perform(competitor_id)
    # Do something later
    competitor = CompetitorProduct.find_by(id: competitor_id)
    return unless competitor && competitor.asin.present?

    data = AmazonPriceFetcher.fetch(competitor.asin)
    competitor.update!(
      latest_price: data[:price],
      latest_rating: data[:rating],
      last_checked_at: Time.current,
      image_url: data[:image],
      amazons_choice: data[:amazons_choice]
    )
    competitor.competitor_snapshots.create!(
      price: data[:price],
      rating: data[:rating],
      captured_at: Time.current
    )

  # ✅ Keep only the last 7 snapshots
  competitor.competitor_snapshots.order(captured_at: :desc).offset(7).destroy_all
  rescue StandardError => e
    Rails.logger.error("Failed to fetch data for CompetitorProduct ID #{competitor_id}: #{e.message}")      
  end
end

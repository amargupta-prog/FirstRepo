class FetchCompetitorDataJob < ApplicationJob
  queue_as :default

  def perform(competitor_id)
    competitor = CompetitorProduct.find_by(id: competitor_id)
    return unless competitor && competitor.asin.present?

    data = AmazonPriceFetcher.fetch(competitor.asin)

    # Save new data into competitor
    competitor.update!(
      latest_price: data[:price],
      latest_rating: data[:rating],
      last_checked_at: Time.current,
      image_url: data[:image],
      amazons_choice: data[:amazons_choice]
    )

    # Only create snapshot if price or rating changed
    last_snapshot = competitor.competitor_snapshots.order(captured_at: :desc).first
    if last_snapshot.nil? ||
       last_snapshot.price != data[:price] ||
       last_snapshot.rating != data[:rating]

      competitor.competitor_snapshots.create!(
        price: data[:price],
        rating: data[:rating],
        captured_at: Time.current
      )
    end

    # keep only the last 10 snapshots
    competitor.competitor_snapshots.order(captured_at: :desc).offset(10).destroy_all
  rescue StandardError => e
    Rails.logger.error("Failed to fetch data for CompetitorProduct ID #{competitor_id}: #{e.message}")
  end
end

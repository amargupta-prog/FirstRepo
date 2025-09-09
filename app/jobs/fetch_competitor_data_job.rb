class FetchCompetitorDataJob < ApplicationJob
  queue_as :default

  def perform(competitor_id)
    # Do something later
    competitor = CompetitorProduct.find_by(id: competitor_id)
    return unless competitor && competitor.asin.present?

    # data = fetch_data_from_api(competitor.asin)
    # return unless data

    # competitor.competitor_snapshots.create!(
    #   price: data[:price],
    #   availability: data[:availability],
    #   captured_at: Time.current
    # )

    data = AmazonPriceFetcher.fetch(competitor.asin)
    competitor.update!(
      latest_price: data[:price],
      latest_rating: data[:rating],
      last_checked_at: Time.current
    )
    competitor.competitor_snapshots.create!(
      price: data[:price],
      rating: data[:rating],
      captured_at: Time.current
    )
  rescue StandardError => e
    Rails.logger.error("Failed to fetch data for CompetitorProduct ID #{competitor_id}: #{e.message}")      
  end
end

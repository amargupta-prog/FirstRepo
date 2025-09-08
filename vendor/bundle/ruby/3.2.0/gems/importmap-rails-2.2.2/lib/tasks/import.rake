namespace :feed do
  desc 'Import Google Merchant TSV from URL or PATH'
  task import: :environment do
    url = ENV['URL'] || 'https://beta.myupchar.com/google_merchant_feed_own.tsv'
    io  = if url =~ %r{^https?://}
            require 'http'
            StringIO.new(HTTP.get(url).to_s)
          else
            File.open(url, 'r:utf-8')
          end
    GoogleMerchantFeedImporter.new(io).call
    puts 'Feed imported.'
  end
end

namespace :competitors do
  desc 'Refresh all competitors with ASIN'
  task refresh_all: :environment do
    CompetitorProduct.with_asin.find_each do |c|
      FetchCompetitorDataJob.perform_now(c.id)
      puts "Refreshed #{c.name} (#{c.asin})"
    end
  end
end

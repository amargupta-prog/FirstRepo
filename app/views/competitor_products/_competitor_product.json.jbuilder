json.extract! competitor_product, :id, :product_id, :name, :platform, :asin, :latest_price, :latest_rating, :last_checked_at, :created_at, :updated_at
json.url competitor_product_url(competitor_product, format: :json)

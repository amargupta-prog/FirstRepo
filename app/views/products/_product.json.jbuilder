json.extract! product, :id, :merchant_id, :title, :price, :currency, :brand, :gtin, :mpn, :link, :image_link, :icp, :created_at, :updated_at
json.url product_url(product, format: :json)

# app/services/google_merchant_feed_importer.rb
require 'csv'
class GoogleMerchantFeedImporter
  DEFAULT_HEADERS = {
    id: 'id', title: 'title', price: 'price', link: 'link',
    brand: 'brand', gtin: 'gtin', mpn: 'mpn', image_link: 'image_link'
  }

  def initialize(io_or_path, headers: DEFAULT_HEADERS)
    @io = io_or_path.respond_to?(:read) ? io_or_path : File.open(io_or_path, 'r:utf-8')
    @headers = headers
  end


  def call
    CSV.new(@io, headers: true, col_sep: "\t").each do |row|
      attrs = extract_attrs(row)
      next unless attrs[:merchant_id].present? || attrs[:title].present?

      product = Product.find_or_initialize_by(merchant_id: attrs[:merchant_id])
      product.assign_attributes(attrs.except(:merchant_id))
      product.save!
    end
  ensure
    @io.close if @io.respond_to?(:close)
  end


  private
  
  def extract_attrs(row)
    raw_price = row[@headers[:price]].to_s
    price_val, currency = parse_price(raw_price)
    {
      merchant_id: row[@headers[:id]].to_s.presence,
      title:       row[@headers[:title]].to_s,
      price:       price_val,
      currency:    currency || 'INR',
      brand:       row[@headers[:brand]].to_s.presence,
      gtin:        row[@headers[:gtin]].to_s.presence,
      mpn:         row[@headers[:mpn]].to_s.presence,
      link:        row[@headers[:link]].to_s.presence,
      image_link:  row[@headers[:image_link]].to_s.presence
    }
  end

  def parse_price(s)
    # Accept formats like "₹1,234.00 INR" or "1234 INR" or "1234"
    currency = s[/[A-Z]{3}\b/] || (s.include?("₹") ? 'INR' : nil)
    num = s.gsub(/[^[0-9].]/, '')
    [num.present? ? num.to_d : nil, currency]
  end
end
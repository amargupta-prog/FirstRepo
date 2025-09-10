# app/services/google_merchant_feed_importer.rb
require 'csv'
class GoogleMerchantFeedImporter
  DEFAULT_HEADERS = {
    id: 'id',
    title: 'title',
    description: 'description',
    brand: 'brand',
    google_product_category: 'google product category',
    product_type: 'product type',
    link: 'link',
    image_link: 'image link',
    condition: 'condition',
    availability: 'availability',
    price: 'price',
    sale_price: 'sale price',
    sale_price_effective_date: 'sale price effective date',
    shipping: 'shipping'
  }

  def initialize(io_or_path, headers: DEFAULT_HEADERS)
    @io = io_or_path.respond_to?(:read) ? io_or_path : File.open(io_or_path, 'r:utf-8')
    @headers = headers
  end


  def call
    # liberal_parsing: true → allows bad quotes
    CSV.new(@io, headers: true, col_sep: "\t", liberal_parsing: true, quote_char: '"').each do |row|
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
    sale_price_val, _ = parse_price(row[@headers[:sale_price]].to_s)
    {
      merchant_id: row[@headers[:id]].to_s.presence,
      title: row[@headers[:title]].to_s,
      description: row[@headers[:description]].to_s.presence,
      price: price_val,
      currency: currency || 'INR',
      brand: row[@headers[:brand]].to_s.presence,
      google_product_category: row[@headers[:google_product_category]].to_s.presence,
      product_type: row[@headers[:product_type]].to_s.presence,
      link: row[@headers[:link]].to_s.presence,
      image_link: row[@headers[:image_link]].to_s.presence,
      condition: row[@headers[:condition]].to_s.presence,
      availability: row[@headers[:availability]].to_s.presence,
      sale_price: sale_price_val,
      sale_price_effective_date: row[@headers[:sale_price_effective_date]].to_s.presence,
      shipping: row[@headers[:shipping]].to_s.presence,
      additional_image_links: collect_additional_images(row)
    }
  end

  def parse_price(s)
    return [nil, nil] if s.blank?
    currency = s[/[A-Z]{3}\b/] || (s.include?("₹") ? 'INR' : nil)
    num = s.gsub(/[^\d.]/, '')
    [num.present? ? num.to_d : nil, currency]
  end

  def collect_additional_images(row)
    keys = row.headers.grep(/^additional_image_link/)
    images = keys.map { |k| row[k].to_s.presence }.compact
    images.any? ? images : nil
  end
end
# /home/myupchar/Downloads/Ror_DE/my_comp_dashboard/app/helpers/asin_helper.rb

# Extracts a 10-character ASIN from an Amazon-style URL path, e.g.
# "https://www.amazon.in/dp/B08L5WHFT9/" => "B08L5WHFT9"

module AsinHelper
  def asin_from_url(url)
    URI(url).path.split('/').detect { |seg| seg =~ /\A[A-Z0-9]{10}\z/ }
  rescue
    nil
  end
end

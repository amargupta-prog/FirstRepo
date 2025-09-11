require 'http'
require 'nokogiri'

class AmazonPriceFetcher
    AMAZON_HOST = 'https://www.amazon.in'
    HEADERS = {
        'User-Agent' => 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/124.0 Safari/537.36',
        'Accept-Language' => 'en-IN,en;q=0.9'
    }

    def self.fetch(asin)
        url = "#{AMAZON_HOST}/dp/#{asin}"
        res = HTTP.timeout(15).headers(HEADERS).get(url)
        unless res.status.success?
            Rails.logger.warn("Amazon HTTP status: #{res.status} for #{asin}")
            return { price: nil, rating: nil, image: nil, amazons_choice: false }
        end

        doc = Nokogiri::HTML(res.body.to_s)
        price = extract_price(doc)
        rating = extract_rating(doc)
        image =  extract_image(doc)
        amazons_choice = extract_amazons_choice(doc)
        { price: price, rating: rating, image: image, amazons_choice: amazons_choice }
    rescue => e
        Rails.logger.warn("Amazon fetch error for #{asin}: #{e.class} #{e.message}")
        { price: nil, rating: nil, image: nil, amazons_choice: false }
    end

    def self.extract_price(doc)
        # selectors that often contain price
        candidates = [
            doc.at_css('#twister-plus-price-data-price')&.[]('value'),
            doc.at_css('#priceblock_ourprice')&.text,
            doc.at_css('#priceblock_dealprice')&.text,
            doc.at_css('#corePrice_feature_div .a-offscreen')&.text,
            doc.at_css('.a-price .a-offscreen')&.text,
            doc.at_css('[data-asin-price]')&.[]('data-asin-price')
        ].compact

        text = candidates.find { |t| t.to_s.strip.length > 0 }
        return nil unless text

        # keep digits and dot
        num = text.to_s.gsub(/[^\d.]/, '')
        return nil if num.blank?

        begin 
            BigDecimal(num)
        rescue 
            nil
        end
    end

    def self.extract_rating(doc)
    # Common places for rating strings like "4.3 out of 5 stars"
        candidates = [
        doc.at_css('[data-hook="rating-out-of-text"]')&.text,
        doc.at_css('i[data-hook="average-star-rating"] span')&.text,
        doc.at_css('#averageCustomerReviews .a-icon-alt')&.text,
        doc.at_css('.cr-vote .a-icon-alt')&.text
        ].compact

        text = candidates.find { |t| t.to_s =~ /[0-5](?:\.[0-9])?/ }
        return nil unless text

        m = text.to_s.match(/([0-5](?:\.[0-9])?)/)
        m ? BigDecimal(m[1]) : nil
    end

    def self.extract_image(doc)
        doc.at_css('#landingImage')&.[]('src') ||
        doc.at_css('#imgBlkFront')&.[]('src') ||
        doc.at_css('#main-image-container img')&.[]('src')
    end

    def self.extract_amazons_choice(doc)
        badge_texts = doc.css('span, div').map(&:text).uniq
        Rails.logger.debug "Amazon badge candidates: #{badge_texts.grep(/amazon/i).take(10)}"
        
        badge_texts.any? { |t| t.to_s.downcase.include?("amazon's choice") }
    end
  
end
require 'open-uri'
# require 'sidekiq-scheduler'


class Search < ApplicationRecord

    # include Sidekiq::Worker

    belongs_to :user
    has_many :listings

    validate :valid_url?

    def run
        doc = Nokogiri::HTML(open(self.url))
        listings = doc.css("li.result-row")
        # binding.pry
        listings.each do |listing|
            listing_url = listing.css("a").first.attributes["href"].value 
            title = listing.css(".result-title").children.text
            price = listing.css(".result-price").first
            if !!price
                price = price.children.text
            end
            location = listing.css(".result-hood").text.strip.gsub(/[()]/, "")
            
            self.listings.find_or_create_by(url: listing_url) do |l|
                l.price = price
                l.title = title
                l.location = location
                l.user_id = self.user.id
            end
        end
        self.listings
    end

    private

    def valid_url?
        doc = Nokogiri::HTML(open(self.url))
        if !doc.css("li.result-row")
            errors.add(:url, "URL must be a valid craigslist results page")
        end
    end

end

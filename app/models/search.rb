require 'open-uri'


class Search < ApplicationRecord

    belongs_to :user
    has_many :listings

    def find_new_listings
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

    def self.schedule_crawl
        while true do
            sleep 1
            puts self.all.count
        end
    end

end

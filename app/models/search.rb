require 'open-uri'


class Search < ApplicationRecord

    belongs_to :user
    has_many :listings

    def find_new_listings
        doc = Nokogiri::HTML(open(self.url))
        listings = doc.css("li.result-row")
        binding.pry
        listings.each do |listing|
            listing_url = listing.css("a").first.attributes["href"].value 
            price = listing.css(".result-price").children.text
            title = listing.css(".result-title").children.text
            location = listing.css(".result-hood").text.strip.gsub(/[()]/, "")
            # image = (find way to image)
            self.listings.find_or_create_by(url: listing_url) do |l|
                l.price = self.parse_price(price)
                l.title = title
                l.location = location
                l.user_id = self.user.id
            end
        end
        self.listings
    end

    def parse_price(price)
        price.match(/(\$\d+)/).captures.first
    end
    
    private

end

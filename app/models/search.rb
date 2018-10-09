require 'open-uri'


class Search < ApplicationRecord

    belongs_to :user
    has_many :listings

    def scrape_url
        doc = Nokogiri::HTML(open(self.url))
        listings = doc.css("li.result-row")
        listings.each do |listing|
            listing_url = listing.css("a").first.attributes["href"].value 
            price = listing.css(".result-price").children.text # problem with this: gives "$25$25" as result
            title = listing.css(".result-title").children.text
            # image = (find way to image)
            self.listings.find_or_create_by({url: listing_url, price: price, title: title})
        end
        binding.pry
    end

end

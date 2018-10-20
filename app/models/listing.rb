require 'open-uri'

class Listing < ApplicationRecord

    belongs_to :user
    belongs_to :search

    validates :url, uniqueness: true

    after_create :parse_listing_page
    
    private
     
    def parse_listing_page
        doc = Nokogiri::HTML(open(self.url))
        self.image = doc.css("img").first.attributes["src"].value if doc.css("img").first
        self.map = doc.css("p.mapaddress small a").first.attributes["href"].value if doc.css("p.mapaddress small a").first
        self.condition = doc.css(".attrgroup b").first.text if doc.css(".attrgroup b").first
        self.save
    end

    def self.delete_old_listings
        self.where('created_at <= ?', 1.day.ago).each {|listing| listing.delete}
    end

end

require 'open-uri'
# require 'sidekiq-scheduler'


class Search < ApplicationRecord

    # include Sidekiq::Worker

    belongs_to :user
    has_many :listings

    validate :valid_url?
    before_save :append_queries
    before_create :append_queries

    after_create :get_base_listings
    after_update :get_base_listings

    def run(is_base = false)
        doc = Nokogiri::HTML(open(self.url))
        listings = doc.css("li.result-row")
        # binding.pry
        listings.each do |listing|
            listing_url = listing.css("a").first.attributes["href"].value 
            title = listing.css(".result-title").children.text
            price = listing.css(".result-price").first.children.text if listing.css(".result-price").first
            location = listing.css(".result-hood").text.strip.gsub(/[()]/, "")
            
            self.listings.find_or_create_by(url: listing_url) do |l|
                l.price = price
                l.title = title
                l.location = location
                l.user_id = self.user.id
                if is_base
                    l.base = true
                end
            end
        end
        self.listings
    end

    def get_base_listings
        self.delay.run(true)
    end


    def append_queries
        if self.has_query?
            if self.ends_with_ampersand?
                if self.has_query_itmes?
                    self.require_sort_date
                    self.require_posted_today
                end
            else
                self.url += "&"
                self.require_sort_date
                self.require_posted_today
            end
        else
            self.url += "?"
            self.require_sort_date
            self.require_posted_today
        end
    end

    def has_query_itmes?
        !!self.url.match(/\?.+/)
    end

    def has_query?
        !!self.url.match(/\?/)
    end

    def ends_with_ampersand?
        self.url.match(/\&$/)
    end

    def require_sort_date
        if !self.url.match(/sort=/)
            self.url += "sort=date&"
        else
            self.url = self.url.gsub(/sort=[a-z]+/, "sort=date")
        end
    end

    def require_posted_today
        if !self.url.match(/postedToday=1/)
            self.url += "postedToday=1&"
        end
    end

    def mark_listings_as_base
        self.listings.where(base: false).each do |listing|
            listing.update(base: true)
        end
    end

    private

    def valid_url?
        doc = Nokogiri::HTML(open(self.url))
        if !doc.css("li.result-row")
            errors.add(:url, "URL must be a valid craigslist results page")
        end
    end

end

class Crawler

    def self.run_searches
        searches = Search.where(active: true)
        
        searches.each do |search|
            search.run
            if search.listings.where(base: false).count > 0
                ListingMailer.send_new_listings(search)
            end
            search.mark_listings_as_base
        end

        self.delay(run_at: 5.minutes.from_now).run_searches
    end

end

# 1. for each search
    # 2. crawl url and gather new listings 
    # 3. email listings to user
    # 4. set all new listings as base (old)
# 5. schedule a new crawl in 5 minutes 
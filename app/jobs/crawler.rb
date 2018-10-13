class Crawler

    def self.run_searches
        searches = Search.where(active: true)
        
        searches.each do |search|
            search.run
        end

        self.delay(run_at: 5.minutes.from_now).run_searches
    end

end
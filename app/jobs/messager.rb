class Messager

    def self.send_emails(search)
        if search.listings.where(base: false).count > 0
            ListingMailer.send_new_listings(search).deliver
        end
    end

    # def self.test_send(search)
    #     ListingMailer.send_new_listings(search).deliver
    # end


end
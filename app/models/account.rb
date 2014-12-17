class Account < ActiveRecord::Base

	def self.from_omniauth(auth)
    where(auth.slice(:provider, :uid)).first_or_initialize.tap do |account|
      account.provider = auth.provider
      account.uid = auth.uid.to_s
      
      unless auth.info.blank?
        account.Name = auth.info.name
        
        account.image = auth.info.image
      end

      account.oauth_token = auth.credentials.token
      account.oauth_expires_at = Time.at(auth.credentials.expires_at) unless auth.credentials.expires_at.nil? 
      account.save!
    end
  end
end

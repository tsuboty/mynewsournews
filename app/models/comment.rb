class Comment < ActiveRecord::Base
	belongs_to :article
	belongs_to :account
	belongs_to :community
end

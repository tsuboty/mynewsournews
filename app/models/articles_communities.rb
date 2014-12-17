class ArticlesCommunities < ActiveRecord::Base
	belongs_to :article
	belongs_to :community 
end

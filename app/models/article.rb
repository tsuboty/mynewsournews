class Article < ActiveRecord::Base
	has_many :comments
	has_and_belongs_to_many :communities
	has_many :read_histories
	has_many :favorites

end

class Community < ActiveRecord::Base
	has_many :comments
	has_and_belongs_to_many :articles
	has_and_belongs_to_many :accounts
	

end


# coding: utf-8
require "twitter"
require "pp"
require "json"

class Twitter_searcher

	def initialize
		@client = Twitter::REST::Client.new do |config|
		  config.consumer_key        = "sbsOAvEZyKOZq6OzmQ9I5ZRsM"
		  config.consumer_secret     = "xDomvBiTGQdlIQpd6XIt0tcyvfEEO834cAKWPV4bKOAraMTI15"
		  config.access_token        = "2446359570-FDFfGBiNSKYBciSWFQyqh7e9q7eZwlaV8qSxqGM"
		  config.access_token_secret = "IOs59LR8SLtlCmKSPHxTCwUHwRxrMK5iHqugaDWlRSI3d"
		end
		@tweets = Array.new
	end

	def search(word,num)
		@tweets = @client.search(word).take(num).collect do |tweet|
			 tweet.to_h
		end
		return @tweets
	end	
end

=begin
test = Twitter_searcher.new
i=0
test.search("日経",10).collect do |t|
	 puts t[:user][:screen_name]
	 puts t[:user][:name]
	

end

=end
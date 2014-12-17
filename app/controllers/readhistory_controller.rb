class ReadhistoryController < ApplicationController
	def record
		history = ReadHistory.new
		history.article_id = params[:article_id]
		history.account_id = params[:account_id]

		history.save

		


	end
end

class AccountController < ApplicationController

	def index
		@accounts = Account.all
		
	end

	def get_salesforce_member
		if session[:token]
			query = "SELECT C_Nikkei_ID__c,C_Users_Interest_tmp__c,Name FROM Account"
			data = SalesforceData.new(session[:token])
			accounts = data.getData(query)["records"]

			accounts.each do |a|
				unless Account.find_by(:Name => a["Name"]) 
					acount = Account.new
					acount.Name = a["Name"]
					acount.Nikkei_ID = a["C_Nikkei_ID__c"]
					acount.Interest = a["C_Users_Interest_tmp__c"]
					acount.save
				end
			end
			redirect_to '/account',notice:"会員登録しました。"
		else
			redirect_to '/account',notice:"会員登録できません。ログインしてください。"
		end

	end




end

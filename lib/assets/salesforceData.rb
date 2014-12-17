require 'net/https'
require 'uri'
require 'json'

class SalesforceData
	@@q_url = "https://ap.salesforce.com/services/data/v30.0/query"
	@@c_url = "https://ap.salesforce.com/services/data/v30.0/sobjects"
	@@h_url = "https://ap.salesforce.com/services/apexrest/ReadHistory"

	def initialize(token="")
		@token = token	
	end

	def getData(query="")
		@query = query
		queryUrl = URI.escape @query
		uri = URI.parse @@q_url
		https = Net::HTTP.new(uri.host,uri.port)
		https.use_ssl = true
		path = uri.path + "?q=" + queryUrl

		#リクエスト
		req = Net::HTTP::Get.new(path, initheader = {'Authorization' =>'OAuth '+@token})
		res = https.request(req)

		#hashにする
		return JSON.parse(res.body)
	end

	#data(hash=>json)をPOSTし、記事を追加する
	def post_kiji(data)
		uri = URI.parse @@c_url
		https = Net::HTTP.new(uri.host,uri.port)
		https.use_ssl = true
		path = uri.path + "/C_Journal__c"

		#リクエスト                
		req = Net::HTTP::Post.new(path, initheader = {'Authorization' =>'OAuth '+@token,'Content-Type' => 'application/json'})
		
		#bodyにデータ格納	
		req.body = data.to_json
		res = https.request(req)

		return res.body
	end

	#閲覧履歴を送付する
	def post_browsing_history(data)
		uri = URI.parse @@h_url
		https = Net::HTTP.new(uri.host,uri.port)
		https.use_ssl = true
		path = uri.path

		req = Net::HTTP::Post.new(path, initheader = {'Authorization' =>'OAuth '+@token,'Content-Type' => 'application/json'})
		req.body = data.to_json
		res = https.request(req)
		return res
	end


end



##ここからテスト
#別途取得したトークン
#token = "00D10000000agFS!AR8AQDtg7tdCZTtrEJCKCsjT2Qjcfx8u1yu.nImKKPZkMAC7.AaEVAYtlXtKXFQeuB2_bd7L5jTuvVKfIlWN16YsKTYmOMp7"
=begin
#get test
query1 = "SELECT C_Users_Interest_tmp__c FROM Account WHERE C_Users_Interest_tmp__c != null"
suzuki = SalesforceData.new(token,query1)
category_id = suzuki.getData["records"][0]["C_Users_Interest_tmp__c"]
puts category_id
query2 = "SELECT Name FROM C_Category__c WHERE Id = " + "\'" + category_id + "\'"
cat = SalesforceData.new(token,query2)
puts cat.getData["records"][0]["Name"]

# post test
kiji = SalesforceData.new(token)
test= {
	Name: "namename"
}
puts kiji.post_kiji(test)


histry = SalesforceData.new(token)

data = {Title: "heroku2"}

puts histry.post_browsing_history(data)


token = "00D10000000agFS!AR8AQDhVEwZsVEdO_5DD0H5AsIsd9cp4uVs_GmwGDUiWKyzasGqFamMJFmIUwXbUfMzL4rzn5dfmXd8qQxBg6U5TqVnYsF08"
query = "SELECT C_Nikkei_ID__c,C_Users_Interest_tmp__c,Name FROM Account"

data = SalesforceData.new(token)
accounts = data.getData(query)["records"]
#puts accounts

accounts.each do |a|
	puts a["Name"]
	puts a["C_Nikkei_ID__c"]
	puts a["C_Users_Interest_tmp__c"]
end
=end


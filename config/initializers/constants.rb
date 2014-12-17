module Constants
    ## Constants::NUMでアクセスできる
    NUM = 1
end

## こっちはTITLEでアクセスできる
TITLE = 'Story Of The Ring'

#ツイッターの取得件数
RETWEET_MAX = 150

#サーチする記事数
SERCH_ARTICLE_MAX = 100

WEB = {
	TOP: "http://www.nikkei.com/",
	SPECIAL: "http://www.nikkei.com/news/special/",
	TOPIC: "http://www.nikkei.com/news/topic/",
	EDITORIAL: "http://www.nikkei.com/news/editorial/"
}

CATEGORY = {
	ECONOMY: "http://www.nikkei.com/news/category/economy/",
	COMPANY: "http://www.nikkei.com/news/category/company/",
	WORLD:    "http://www.nikkei.com/news/category/world/",
	POLITICS: "http://www.nikkei.com/news/category/politics/",
	MARKETS: "http://www.nikkei.com/news/category/markets/",
	SPORTS: "http://www.nikkei.com/news/category/sports/",
	NATIONAL: "http://www.nikkei.com/news/category/national/",
	FINANCE: "http://www.nikkei.com/news/category/finance/",
	LOCAL: "http://www.nikkei.com/news/local/"
}



if Rails.env == "production"
    ENV['SALESFORCE_KEY'] = "3MVG9I1kFE5Iul2DQWTvqFt4CWN41Old4ah2p02KOxugKjkvZXLPSugJ0Z3dNsGEwiWlRRsh5tkfzbf0wG0ts"
	ENV['SALESFORCE_SECRET'] = "2690942053707586539"
	ENV['FACEBOOK_KEY'] = "1474510439503045"
	ENV['FACEBOOK_SECRET'] = "32c61ec10993eb305041635917c6b045"

else #test
    ENV['SALESFORCE_KEY'] = "3MVG9I1kFE5Iul2DQWTvqFt4CWI0tJvtu26M8GCf0hgKRpnRKy1TqdFClTEp6h1kEDJIWhuZ0ol6SRgYNizc5"
	ENV['SALESFORCE_SECRET'] = "4245992424027153340"
	ENV['FACEBOOK_KEY'] = "648232061957277"
	ENV['FACEBOOK_SECRET'] = "d48e69ebac7ff658e5ac7cabe2c20e64"
end


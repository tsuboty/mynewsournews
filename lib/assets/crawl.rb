require 'nokogiri'
require 'open-uri'
require 'date'
require 'json'

class Crawl

	def initialize(url,category)
		@url = url
		@category = category
		@articles = Array.new
		@charset = nil
		@html = open(@url) do |f|
			@charset = f.charset
			f.read
		end
		@doc = Nokogiri::HTML.parse(@html,nil,@charset)
	
	end

	#速報ニュース(複数)をクロールする
	def crawlNews
		
		section = @doc.css(".cmn-section").css('a:not(.cmnc-continue)')

		section.each do |node|
			@article = Article.new
			@article.headline = node.css('span').text
			@article.link = "http://www.nikkei.com" + node.attr("href")
			@article.category = @category
			@article.img = ""
			@article.capturedDate = Date.today
			@article.content = self.crawlHonbun(@article.link)

			@articles << @article
		end

		return @articles	
	end

	#トップニュース(単数)をクロールする
	def crawlTopNews
		
		main = @doc.css(".nx-top_news_first")

		@article = Article.new
		@article.headline = main.css(".cmn-article_title a span").text
		@article.link = "http://www.nikkei.com" + main.css(".cmn-article_title a").attr("href")
		@article.category = @category
		img = main.css(".cmn-photo_style1 a img")
		
		
		if img then
			@article.img   = "http://www.nikkei.com" + img.attr("src")
		end

		@article.capturedDate = Date.today

		@article.content = self.crawlHonbun(@article.link)

		return @article
	end

	def crawlHonbun(detail_url)

		@html = open(detail_url) do |f|
			@charset = f.charset
			f.read
		end
		@doc = Nokogiri::HTML.parse(@html,nil,@charset)
				
		honbun = ""
		if @doc.css("#JSID_textReport").text != ""
			honbun = @doc.css("#JSID_textReport").inner_html
		elsif @doc.css(".cmn-article_text").text != ""
			honbun = @doc.css(".cmn-article_text").inner_html
		else
			honbun = "null"
		end
		
		return honbun
	end


end

=begin
url = ["http://www.nikkei.com/article/DGXLASS0ISS15_Y4A021C1000000/",
		"http://www.nikkei.com/article/DGXLASJC28H1D_Y4A021C1000000/",
		"http://www.nikkei.com/markets/kigyo/gyoseki.aspx?g=DGXLASFL29H88_29102014000000"
		]
crawldata = Crawl.new(url[2],"TOP")

articles = crawldata.crawlHonbun()


puts articles


=end
require 'assets/crawl'
require 'assets/salesforceData'
require 'assets/twitter_searcher'
require 'json'
require 'parallel'


class ArticlesController < ApplicationController

	def index
		@articles = Article.order(id: :desc).limit(500)
		session[:sidebar] = false		
	end

	def create
		@article = Article.new(article_params)
	end

	def new
	end

	def edit
	end

	def show
	end

	def update
	end

	def destroy
	end

	#記事一覧を取得
	def crawl
		CATEGORY.each do |key,url|
			crawldata = Crawl.new(url,key)

			articles = crawldata.crawlNews()

			articles.each do |item|
				@article = Article.new

				#重複チェック
				unless Article.find_by(headline: item.headline) 
					@article.headline = item.headline
					@article.category = item.category
					@article.link = item.link
					@article.img = item.img
					@article.content = item.content.to_s
					@article.capturedDate = item.capturedDate
					@article.save
				end	
				ActiveRecord::Base.connection.close 
			end		
		end

		#TOP記事
		crowled_data = Crawl.new(WEB[:TOP],"TOP")
		@top_article = crowled_data.crawlTopNews

		#重複チェック
		unless Article.find_by(headline: @top_article.headline,category: @top_article.category)
			@top_article.save
		end

    	redirect_to :action => "index"

	end

	#salesforceに記事登録
	def send_to_salesforce
		articles = Article.where(send_article_flg: nil)
	#	render text: articles.to_json

		salesforce = SalesforceData.new(session[:token])

		articles.each do |article|
			data = {
				Name: article.headline,
				C_Journal_URL__c: article.link,
				C_Issue_Date__c: article.capturedDate
			}		
			salesforce.post_kiji(data)
			article.send_article_flg = true
			article.save
		end
#		redirect_to :action => "index"
	end

	def resetArticle
		Article.destroy_all
		redirect_to :action => "index"
	end

	def send_read_info
		salesforce = SalesforceData.new(session[:token])

		#JournalURLが入らない
		data = {
				Title: params[:Title],
				JournalURL: params[:JournalURL],
				IssueDate: params[:IssueDate]
		}	
		salesforce.post_browsing_history(data)
		render :index
	end

	def twitter
		@article = Article.find(params[:id])
		twitter = Twitter_searcher.new
		@word = twitter.search(@article.headline,SERCH_ARTICLE_MAX)
		@article.retweet_num = @word.size
		@article.save
	end

	def rt_search
		@articles = Article.order(id: :desc).limit(SERCH_ARTICLE_MAX)	
		after_rt_search(@articles)
	end

	def rt_search_all
		@articles = Article.order(id: :desc).where.not(retweet_num: RETWEET_MAX)
		after_rt_search(@articles)
	end

	def after_rt_search(articles)

		Parallel.each(articles,in_threads: 2) do |at|
			twitter = Twitter_searcher.new
			if at.retweet_num.nil?
				@word = twitter.search(at.headline,RETWEET_MAX)
				at.retweet_num = @word.size
				at.save
			end
		end
		render :index
	end

	def favorite
		@article_id = params[:article_id]
		@account_id = session[:account_id]
		logger.debug("Hello, world!")

		if f = Favorite.find_by(article_id: @article_id,account_id: @account_id)
			
			if f.favorite_flag
				f.favorite_flag = false
				logger.debug("記事のフラグをはずしました。")
			else
				f.favorite_flag = true
				logger.debug("記事のフラグを登録しました。")
			end
			f.save

		else
			logger.debug("新規にお気に入りを登録しました。")
			f = Favorite.new
			f.article_id = @article_id
			f.account_id = @account_id
			f.favorite_flag = 1
			f.save
		end

		#@articles = Article.where.not(retweet_num: nil).order(retweet_num: :desc).limit(SERCH_ARTICLE_MAX)
		
	end


	private
		def article_params
			params.require(:article).permit(:headline,:category,:link,:img,:content,:capturedDate,:honbunFlg)
  		end
end

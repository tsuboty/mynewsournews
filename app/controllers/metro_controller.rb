#encoding: utf-8
require 'json'

class MetroController < ApplicationController

	def index


	end
	def article_index
		@economy = Article.where(category: 'ECONOMY').count
		@company = Article.where(category: 'COMPANY').count
		@world = Article.where(category: 'WORLD').count
		@politics = Article.where(category: 'POLITICS').count
		@markets = Article.where(category: 'MARKETS').count
		@sports = Article.where(category: 'SPORTS').count
		@national = Article.where(category: 'NATIONAL').count
		@finance = Article.where(category: 'FINANCE').count
		@local = Article.where(category: 'LOCAL').count
		@top = Article.where(category: 'TOP').last
	  @favorite = @favorite_ids = Favorite.where(account_id: session[:account_id],favorite_flag: true).count
	end

	def pickup_article
		@category = params[:category]
		@community = Community.all
		@page = params[:page]
		response.headers['X-Frame-Options'] = "ALLOWALL"

		@favorite_ids = Favorite.where(account_id: session[:account_id],favorite_flag: true).pluck(:article_id)
		#@favorite_ids


		if CATEGORY.has_key?(@category.to_sym)
			@pickup_article = Article.where(category: @category).page(@page).per(10).order(id: :desc)

		elsif @category=="ラウンジ"
			redirect_to '/lounge'
		else
			@pickup_article = Article.where("headline like '%#{@category}%'").page(@page).per(10).order(id: :desc)
		end
	end

	def favorite
		@favorite_ids = Favorite.where(account_id: session[:account_id],favorite_flag: true).pluck(:article_id)
		@articles = Article.where("id IN (?)", @favorite_ids)
	end

	def check
		article_id = params[:article_id]
		favorite = Favorite.find_by(account_id: session[:account_id],article_id: article_id)

		favorite.favorite_flag = favorite.favorite_flag ? false : true
		favorite.save

		render text: favorite.favorite_flag

	end

	def login
		id = params[:email]
		pw = params[:password]


		if @account = Account.find_by(Nikkei_ID: id)
			session[:account] = @account.Name
			session[:account_id] = @account.id
			redirect_to '/'
		else
			render text: "ログイン失敗"
		end
	end

	def logout
		session[:account] = nil
		redirect_to '/'
	end

	def lounge

	end

	def clip_topic

		@articles_communities = ArticlesCommunities.new()
		@articles_communities.article_id = params[:article_id]
		@articles_communities.community_id = params[:community_id]
		@articles_communities.save

		#ajaxでエラーのためダミー設置
		render text: " "
	end

	def create_account
		name = params[:name]

		@account = Account.new()
		@account.Name = name
		@account.provider = "none"
		@account.Nikkei_ID = params[:id]

		@account.save

		redirect_to "/"

	end

	def create_account_form


	end

	def analysis
		@read_histories = ReadHistory.where(account_id: session[:account_id])
		@categories = {}
		@read_histories.each do |r|
			@categories.append(Article.select(:category).find(r.article_id).category)
		end


		#render json: @read_history
	end

	private
		def articles_communities_params
			params.require(:articles_communities).permit(:article_id,:community_id)
		end



end

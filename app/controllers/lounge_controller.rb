# -*- encoding: utf-8 -*-
class LoungeController < ApplicationController

	before_action :set_community, only: [:enter_lounge, :edit_lounge, :update_lounge,:delete_lounge,:comments,:update_comment,:destroy_comment,:edit_comment,:destroy_topics]
	before_action :set_comment, only: [:edit_comment,:update_comment,:destroy_comment]
	before_action :set_article, only: [:edit_comment,:comments,:update_comment,:destroy_comment,:destroy_topics]

	def index
		@community = Community.all
	end

#コミュニティ関連
	def enter_lounge
	end

	def show_lounge
		@community = Community.all
	end

	def edit_lounge
	end

	def update_lounge
		@community.id = params[:id]
		@community.body = params[:body]
		@community.save
		redirect_to "/lounge/show"
	end

	def new_lounge
		@community = Community.new()
	end

	def create_lounge
		@community = Community.new()
		@community.body = params[:community_name]
		@community.save
		redirect_to "/lounge/show"
	end

	def delete_lounge
		@community.destroy
		redirect_to "/lounge/show"
	end


#トッピックス関連
	def new_topics
		@articles_communities = ArticlesCommunities.new()
		@community_id = params[:community_id]
	end

	def create_topics
		@articles_communities = ArticlesCommunities.new(articles_communities_params)
		if @articles_communities.save
			redirect_to :action => "enter_lounge"
		else
			redirect_to :action => "new_topics"
		end
	end

	def destroy_topics
		@articles_communities = ArticlesCommunities.find_by(article_id: @article.id,community_id: @community.id)
		if @articles_communities.present? then
      		@articles_communities.destroy
    	end
    	url = URI.encode("/lounge/" + @community.id.to_s)
		redirect_to url	
	end

#コメント関連
	def comments		
		@comments = Comment.where(article_id: @article.id,community_id: @community.id)
		if @commnets.nil?
			@comments = Comment.where(article_id: @article.id)
		end


	end

	def create_comment
		@comment = Comment.new()
		@comment.body = params[:comment]
		@comment.article_id = params[:id]
		@comment.community_id = params[:community_id]
		@comment.account_id = session[:account_id]
		@comment.save
		redirect_to URI.encode("/lounge/" + params[:community_id] + "/" + params[:id])
	end

	def edit_comment	
	end

	def update_comment
		@comment.body = params[:comment]
		if @comment.save
			url = URI.encode("/lounge/" + @community.id.to_s + "/" + @article.id.to_s)
			redirect_to url
		end
	end

	def destroy_comment
		if @comment.destroy
			url = URI.encode("/lounge/" + @community.id.to_s + "/" + @article.id.to_s)
			redirect_to url
		end
	end


	private
		def articles_communities_params
			params.require(:articles_communities).permit(:article_id,:community_id)
		end

		def set_articles_communities
			@articles_communities = ArticlesCommunities.find(params[:id])
		end

		def set_community
			@community = Community.find(params[:community_id])	
		end

		def set_comment
			@comment = Comment.find(params[:comment_id])
		end

		def set_article
			@article = Article.find(params[:id])
		end
end

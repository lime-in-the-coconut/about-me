class ArticlesController < ApplicationController
	include ArticlesHelper
	

before_filter :require_login, only: [:new, :create, :edit, :update, :destroy]

	def index
		@articles = Article.order(:title).page(params[:page])
	end

	def show
		@article = Article.find(params[:id])
		@comment = Comment.new
		@comment.article_id = @article.id
	end

	def new
		@article = Article.new
	end

	def create
		@article = Article.new(article_params)
		@article.save

		flash.notice = "'#{@article.title}' is a lovely new article:)"

		redirect_to article_path(@article)
	end

	def destroy
		@article = Article.find(params[:id]).destroy
		@article.destroy

		flash.notice = "Are you sure you want to scrap '#{@article.title}' ?"

		redirect_to articles_path
	end

	def edit
		@article = Article.find(params[:id])
	end

	def update
		@article = Article.find(params[:id])
		@article.update(article_params)

		flash.notice = "Article '#{@article.title}' is much better now!"

		redirect_to article_path(@article)
	end

	def remove_image
		@article = Article.find(params[:id])
		@article.image.destroy
		redirect_to edit_article_path(@article)
	end
end

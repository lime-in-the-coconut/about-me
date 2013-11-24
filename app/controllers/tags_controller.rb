class TagsController < ApplicationController
		include TagsHelper

	before_filter :require_login, only: [:destroy]

	def show
		@tag = Tag.find(params[:id])
	end

	def index
		@tags = Tag.all
	end

	def edit
		@tag = Tag.find(params[:id])
	end

	def update
		@tag = Tag.find(params[:id])
		@tag.update(tag_params)

		flash.notice = "Tag '#{@tag.name}' is much better now!"

		redirect_to tag_path(@tag)
	end

	def destroy
		@tag = Tag.find(params[:id]).destroy
		@tag.destroy

		flash.notice = "Are you sure you want to scrap '#{@tag.name}' ?"

		redirect_to tags_path
	end

end

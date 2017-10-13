class VideosController < ApplicationController
	before_action :find_video, only: [:show, :edit, :update, :destroy]
	before_action :authenticate_user!, only: [:new, :edit]

	def index
		if params[:category].blank?
			@videos = Video.all.order("created_at DESC")
		else
			@category_id = Category.find_by(name: params[:category]).id
			@videos = Video.where(:category_id => @category_id).order("created_at DESC")
		end
	end

	def show
		if @video.reviews.blank?
			@average_review = 0
		else
			@average_review = @video.reviews.average(:rating).round(2)
		end
	end

	def new
		#@video = Video.new
		@video = current_user.videos.build
		@categories = Category.all.map{|c| [c.name, c.id]}
	end

	def create
		#@video = Video.new(video_params)
		@video = current_user.videos.build(video_params)
		@video.category_id = params[:category_id]

		if @video.save
			redirect_to root_path
		else
			render 'new'
		end
	end

	def edit
		@categories = Category.all.map{|c| [c.name, c.id]}
	end

	def update
		@video.category_id = params[:category_id]
		if @video.update(video_params)
			redirect_to video_path(@video)
		else
			render 'edit'
		end
	end

	def destroy
		@video.destroy
		redirect_to root_path
	end

	private

		def video_params
			params.require(:video).permit(:name, :description, :director, :category_id, :video_img)
		end

		def find_video
			@video = Video.find(params[:id])
		end

end

class RegionsController < ApplicationController

	before_action :get_region, only: [:edit, :update, :show]

	def index
		@regions = Region.all
	end

	def new
		@region = Region.new
	end

	def create
		@region = Region.new(region_params)
		if @region.save
			flash[:success] = "The region was added"
			redirect_to regions_path
		else
			flash.now[:warning] = "The region was not added"
			render 'new'
		end
	end

	def show
	end

	def edit
	end

	def update
		if @region.update(region_params)
			flash[:success] = "The region was successfully updated"
			redirect_to @region
		else
			flash.now[:warning] = "The region was not updated"
			render 'edit'
		end
	end



	private

		def region_params
			params.require(:region).permit(:name)
		end

		def get_region
			@region = Region.find(params[:id])
		end
end

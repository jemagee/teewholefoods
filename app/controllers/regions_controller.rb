class RegionsController < ApplicationController

	def new
		@region = Region.new
	end

	def create
		@region = Region.new(region_params)
		if @region.save
			flash[:success] = "The region was added"
			redirect_to regions_path
		else
			flash[:warning] = "The region was not added"
			render 'new'
		end
	end

	def index
		@regions = Region.all
	end

	private

		def region_params
			params.require(:region).permit(:name)
		end
end

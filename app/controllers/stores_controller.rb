class StoresController < ApplicationController

	def new
		@store = Store.new
	end

	def create
		@store = Store.new(store_params)
		@store.save
		flash[:success] = "The store was added"
		redirect_to @store
	end

	def show
		@store = Store.find(params[:id])
	end

	private
		def store_params

			params.require(:store).permit(:name, :number, :region_id)
			
		end
end

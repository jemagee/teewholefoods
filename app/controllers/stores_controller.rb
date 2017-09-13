class StoresController < ApplicationController

	before_action :get_store, only: [:show, :edit, :update, :destroy]

	def new
		@store = Store.new
	end

	def create
		@store = Store.new(store_params)
		if @store.save
			flash[:success] = "The store was added"
			redirect_to @store
		else
			flash.now[:warning] = "The store was not added"
			render 'new'
		end
	end

	def show
	end

	def edit
	end

	def update
		if @store.update(store_params)
			flash[:success] = "The store has been updated"
			redirect_to @store
		else
			flash.now[:warning] = "The store was not updated"
			render 'edit'
		end
	end

	def destroy
		@store.update(open: false)
		flash[:success] = "The store was marked as closed"
		redirect_to @store.region
	end

	private
		def store_params
			params.require(:store).permit(:name, :number, :region_id)
		end

		def get_store
			@store = Store.find(params[:id])
		end
end

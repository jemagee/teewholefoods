class ItemsController < ApplicationController

	def new
		@item = Item.new
	end

	def create
		@item = Item.new(item_params)
		if @item.save
			flash[:success] = "The item was added"
			redirect_to @item
		else
			flash[:warning] = "The item was not added"
			render 'new'
		end
	end

	def show
		@item = Item.find(params[:id])
	end

	private

		def item_params
			params.require(:item).permit(:name, :number)
		end
end

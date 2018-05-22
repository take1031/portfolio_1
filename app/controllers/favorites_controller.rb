class FavoritesController < ApplicationController
	before_action :authenticate

	def create
		@product = Product.find(params[:product_id])
	  	@products = Product.paginate(:page => params[:page], :per_page => 12)
		@favorite = current_user.favorites.build(product: @product)

		respond_to do |format|
			if @favorite.save
				format.html{redirect_back(fallback_location: store_path)}
				format.js
				format.json{head :ok}			
			else
				format.html{redirect_back(fallback_location: store_path)}
			end
		end
	end

	def destroy
		@product = Product.find(params[:product_id])
	  	@products = Product.paginate(:page => params[:page], :per_page => 12)
		@favorite = current_user.favorites.find_by!(product_id: params[:product_id])
		@favorite.destroy

		respond_to do |format|
			format.html{redirect_back(fallback_location: store_path)}
			format.js
			format.json{head :ok}
        end 
	end
end

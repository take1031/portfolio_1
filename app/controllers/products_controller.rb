class ProductsController < ApplicationController
  # before_action :set_product, only: [:show, :edit, :update, :destroy, :pay]
  # before_action :authenticate_user!
  def index
  	@products = Product.all
  end
  def new
  	@product = Product.new	
  end
  def create
  	@product = Product.new(product_params)
  	
  	respond_to do |format|
      if @product.save
        format.html { redirect_to @product, notice: 'Product was successfully created.' }
        format.json { render :show, status: :created, location: @product }
      else
        format.html { render :new }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end
  def show
  	@product = Product.find_by(id: params[:id])
  end
  def edit
  	
  end
  def update

    @product = Product.find_by(id: params[:id])

    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to @product, notice: 'Product was successfully updated.' }
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end
  def destroy

  	@product = Product.find_by(id: params[:id])

    @product.destroy
    respond_to do |format|
      format.html { redirect_to products_url, notice: 'Product was successfully destroyed.' }
      format.json { head :no_content }
    end
  end



  private
    def set_product
      @product = Product.find(params[:id])
    end

    def product_params
      params.require(:product).permit(:title, :description, :image_url, :price)
    end
end

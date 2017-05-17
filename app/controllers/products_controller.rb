class ProductsController < ApplicationController
  def index
    @products = Product.all
  end

  def show
    @product = product.find(params[:id])
  end
  
end

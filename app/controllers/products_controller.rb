class ProductsController < ApplicationController
  def index
    @categories = Category.all

    categ = params[:categ]

    if !categ.nil?
      @products = Product.where(:category_id => categ).search(params[:search])
    else
      @products = Product.search(params[:search]).order("created_at DESC")
    end
    @product = Product.offset(rand(Product.count)).first
    @order_item = current_order.order_items.new
  end

  def new
    @product = current_user.products.build
  end

  def create
    @product = current_user.products.build(product_params)
    if @product.save
      redirect_to products_path
    else
      render "new"
    end
  end

  def show
    @product = Product.find(params[:id])
    @order_item = current_order.order_items.new
  end

  def edit
    @product = Product.find(params[:id])
  end

  def update
    @product = Product.find(params[:id])
    if @product.update_attributes(product_params)
      redirect_to products_path
    else
      render "edit"
    end
  end

  def destroy
    @product = Product.find(params[:id])
    @product.destroy
    redirect_to products_path
  end

  private

  def product_params
    params.require(:product).permit(:name, :description, :price, :image, :category_id)
  end
end

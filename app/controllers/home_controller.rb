class HomeController < ApplicationController
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
end

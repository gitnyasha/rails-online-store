class OrderItemsController < ApplicationController
  def create
    @order = current_order
    @order_item = @order.order_items.new(order_item_params)
    @order_item.save

    session[:order_id] = @order.id
  end

  def update
    @order = current_order
    @order_item = @order.order_items.find(params[:id])
    respond_to do |format|
      if @order_item.update_attributes(order_item_params)
        @order_items = @order.order_items
        format.js { render js: "window.top.location.reload(true);" }
      end
    end
  end

  def destroy
    @order = current_order
    @order_item = @order.order_items.find(params[:id])
    respond_to do |format|
      if @order_item.destroy
        format.js { render js: "window.top.location.reload(true);" }
      end
    end
    @order_items = @order.order_items
  end

  private

  def order_item_params
    params.require(:order_item).permit(:product_id, :quantity)
  end
end

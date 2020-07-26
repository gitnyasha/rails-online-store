class OrdersController < ApplicationController
  def new
    @order_items = current_order.order_items
    @order = Order.new
  end

  def create
    @order = Order.new(order_params)
    if @order.save
      paynow = Paynow.new(ENV["INTEGRATION_ID"], ENV["INTEGRATION_KEY"], "https://doucetech.herokuapp.com/", "https://doucetech.herokuapp.com/")

      payment = paynow.create_payment(@order.id, @order.email)
      payment.add("goods", current_order.subtotal)
      response = paynow.send(payment)

      if response.success
        redirect_to response.redirect_url
        # poll_url = response.poll_url
        # print("Poll Url: ", poll_url)
        # status = paynow.check_transaction_status(poll_url)
        # print("Payment Status: ", status.status)
      end
    else
      flash[:alert] = "Error encountered."
      redirect_to new_order_path
    end
  end

  private

  # Only allow a list of trusted parameters through.
  def order_params
    params.require(:order).permit(:address, :first_name, :last_name, :city, :phone, :email, :additional)
  end
end

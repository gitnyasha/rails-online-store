class AddPhoneToOrders < ActiveRecord::Migration[6.0]
  def change
    add_column :orders, :phone, :string
  end
end

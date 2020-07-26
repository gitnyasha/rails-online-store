class AddAdditionalToOrders < ActiveRecord::Migration[6.0]
  def change
    add_column :orders, :additional, :text
  end
end

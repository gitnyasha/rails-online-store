class AddCityToOrders < ActiveRecord::Migration[6.0]
  def change
    add_column :orders, :city, :string
  end
end

class RemoveLineItemIdfromOrders < ActiveRecord::Migration[6.0]
  def change
    remove_column :orders, :line_item_id
    remove_column :inventories, :line_item_id
  end
end

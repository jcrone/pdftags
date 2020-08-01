class ChangeColumnName < ActiveRecord::Migration[6.0]
  def change
    rename_column :line_items, :orders_id, :order_id
  end
end

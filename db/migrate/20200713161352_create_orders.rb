class CreateOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :orders do |t|
      t.string :customer
      t.decimal :total
      t.integer :line_item_id

      t.timestamps
    end
  end
end

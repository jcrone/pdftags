class CreateInventories < ActiveRecord::Migration[6.0]
  def change
    create_table :inventories do |t|
      t.decimal :price
      t.string :category
      t.string :description
      t.integer :line_item_id

      t.timestamps
    end
  end
end

class CreateLineItem < ActiveRecord::Migration[6.0]
  def change
    create_table :line_items do |t|
      t.references :inventory, null: false, foreign_key: true
      t.references :orders, null: false, foreign_key: true
      t.timestamps
    end
  end
end

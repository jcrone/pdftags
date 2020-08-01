class Order < ApplicationRecord
  has_many :line_items
  has_many :inventories, :through => :line_items
end

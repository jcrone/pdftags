class OrderPdf < Prawn::Document
  include ActionView::Helpers::NumberHelper # <-
  def initialize(order)
    super()
    @order = order
    order_number

  end

  def order_number
    define_grid(:top_margin => 38,:bottom_margin => 38, :left_margin => 16, :right_margin => 16,
               :columns => 2, :rows => 5, :column_gutter => 18, :row_gutter => 0)
      x = 0
      y = 0
      @order.inventories.map do |inventory|
        price = number_to_currency(inventory.price, precision: 0)
        grid(x, y).bounding_box do
    pad_top(20){text "Order \##{@order.id}", size:14, style: :bold}
          text " #{inventory.description}"
          text "#{inventory.category}"
          text " #{price}"
          text " #{x}"
          text " #{y}"
          if x == 4 and y == 1
             x = 0
             y = 0
             start_new_page
          elsif y == 0
            y = 1
          else
            x = x + 1
            y = 0
          end
        end
      end

      grid.show_all
  end

  def line_items
    move_down 20
    table line_item_rows
  end

  def line_item_rows
    [["Product", "Category", "Price"]] +
    @order.inventories.map do |inventory|
      [inventory.description, inventory.category, inventory.price]
    end
  end
end

class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :edit, :update, :destroy]

  # GET /orders
  # GET /orders.json
  def index
    @orders = Order.all
    respond_to do |format|
      format.html
      format.pdf do
        names = ["Jordan", "Chris", "Jon", "Mike", "Kelly", "Bob", "Greg"]

        labels = Prawn::Labels.render(names, :type => "Avery5163") do |pdf, name|
          pdf.text name
        end

        send_data labels, :filename => "names.pdf", :type => "application/pdf"
        end
      end

    end

  # GET /orders/1
  # GET /orders/1.json
  def show
    @inventory = @order.inventories
    respond_to do |format|
      format.html
      format.pdf do
        pdf = OrderPdf.new(@order)
        send_data pdf.render, filename: "order_#{@order.id}_#{Time.new}.pdf",
                              type: "application/pdf",
                              disposition: "inline"
      end
    end
  end

  # GET /orders/new
  def new
    @order = Order.new
    respond_to do |format|
      format.html
      format.docx do
        template = Sablon.template(File.expand_path("app/assets/docs/inventory.docx"))
        context = {
          inventory: "Testing",
            }

        template.render_to_file File.expand_path("app/assets/docs/output.docx"), context

        send_data template, :filename => "Test.docx", :type => "application/docx"
        end
      end
  end

  # GET /orders/1/edit
  def edit
  end

  # POST /orders
  # POST /orders.json
  def create
    @order = Order.new(order_params)

    respond_to do |format|
      if @order.save
        format.html { redirect_to @order, notice: 'Order was successfully created.' }
        format.json { render :show, status: :created, location: @order }
      else
        format.html { render :new }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /orders/1
  # PATCH/PUT /orders/1.json
  def update
    respond_to do |format|
      if @order.update(order_params)
        format.html { redirect_to @order, notice: 'Order was successfully updated.' }
        format.json { render :show, status: :ok, location: @order }
      else
        format.html { render :edit }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1
  # DELETE /orders/1.json
  def destroy
    @order.destroy
    respond_to do |format|
      format.html { redirect_to orders_url, notice: 'Order was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def order_params
      params.require(:order).permit(:customer, :total, :line_item_id)
    end
end

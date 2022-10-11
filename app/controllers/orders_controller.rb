class OrdersController < ApplicationController
  # before_action :require_user
  before_action :set_order, only: %i[ show edit update destroy ]

  # GET /orders or /orders.json
  def index
    if Redis.current.get("shopper_id") == nil
      @orders = Order.where(retailer_id: Redis.current.get("retailer_id"), status: 0)
      # @orders = Order.all
    else
      @orders = Order.where(shopper_id: Redis.current.get("shopper_id"))
    end
  end

  # GET /orders/1 or /orders/1.json
  def show
    @order = Order.find(params[:id])
    @prods = @order.products
  end

  # GET /orders/new
  def new
    # @order = Order.new
    client = Ignite::Client.new
    # @order = client.query("SELECT * FROM ORDERS WHERE SHOPPER_ID = #{Redis.current.get("shopper_id")}") 
    @cart = client.query("SELECT * FROM CARTS WHERE SHOPPER_ID = #{Redis.current.get("shopper_id")} AND ORDER_ID = 0")
    # @order[0]["SHOPPER_ID"] = Redis.current.get("shopper_id");
    # @order[0]["SHOPPER_ADDR"] = Redis.current.get("address_detail");
    # @order[0]["RETAILER_ID"] = Redis.current.get("retailer_id");
    # @order[0]["ITEMS"] = @cart[0]["ITEMS"]
    # @order[0]["GRAND_TOTAL"] = @cart[0]["TOTAL"]
    # @order[0]["STATUS"] = 1
    # @cart = Cart.where(shopper_id: Redis.current.get("shopper_id")).pluck(:total, :products)
    # @order.products = @cart[0][1] #Redis.current.get("product_id");
    # @order.grand_total = @cart[0][0]
    $i =0;
    count = client.query("SELECT COUNT(ID) FROM ORDERS")
    $ID = count[0]["COUNT(ID)"] + 1
    $grand_total = 0
    while @cart[$i] != nil
      client.query("UPDATE PUBLIC.CARTS SET ORDER_ID=#{$ID} WHERE ID=#{@cart[$i]["ID"]};")
      $grand_total += @cart[$i]["TOTAL"] # * @cart[$i]["QTY"]
      $i += 1
    end
    Redis.current.set("grand_total-#{$ID}","#{$grand_total}")
    client.query("INSERT INTO PUBLIC.ORDERS(ID, SHOPPER_ID, SHOPPER_ADDR, RETAILER_ID, GRAND_TOTAL, STATUS)VALUES(#{$ID}, #{Redis.current.get("shopper_id")}, '#{Redis.current.get("address_detail")}', #{Redis.current.get("retailer_id")}, #{$grand_total}, 1,)")
    @ogt = Redis.current.get("grand_total-#{$ID}")
    @un = Redis.current.get("shopper_name")
    # @order.save
    # EmailJob.perform_now(4) #4 means this one has to go for order placed by Shopper email method 
    # Cart.where(shopper_id: Redis.current.get("shopper_id")).destroy_all
  end

  # GET /orders/1/edit
  def edit
  end

  # POST /orders or /orders.json
  def create
    @order = Order.new(order_params)
    respond_to do |format|
      if @order.save
        format.html { redirect_to order_url(@order), notice: "Order was successfully created." }
        format.json { render :show, status: :created, location: @order }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /orders/1 or /orders/1.json
  def update    
    ########### KAFKA ##############
    require "kafka"
    # kafka = Kafka.new(seed_brokers: "9092", client_id: "eshop", logger: Rails.logger)
    kafka = Kafka.new(seed_brokers:["localhost:9092"],logger: Rails.logger)
    producer = kafka.async_producer(
      # Trigger a delivery once 100 messages have been buffered.
      delivery_threshold: 100,
      # Trigger a delivery every 30 seconds.
      delivery_interval: 30,
    )
    event = {
      order_id: "#{@order.id}",
      status: @order.status,
      timestamp: Time.now,
    }
    #  partition_key = rand(100)
    producer.produce(event.to_json,topic: "orer-test-event")
    producer.deliver_messages      

    respond_to do |format|
      if @order.update(order_params)
        Redis.current.set("order_id",@order.id)
        # EmailJob.perform_now(5) #5 means this one has to go for order status change  email
        format.html { redirect_to order_url(@order), notice: "Order was successfully updated." }
        format.json { render :show, status: :ok, location: @order }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1 or /orders/1.json
  def destroy
    @order.destroy
    respond_to do |format|
      format.html { redirect_to orders_url, notice: "Order was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
      @cart = Cart.where(shopper_id: Redis.current.get("shopper_id"))
      puts "================CART FOUND AS: #{@cart[0]}================="
      @prods = @order.products
    end

    # Only allow a list of trusted parameters through.
    def order_params
      params.require(:order).permit(:status)
    end
end


# class OrdersController < ApplicationController
#   before_action :set_order, only: %i[ show edit update destroy ]

#   # GET /orders or /orders.json
#   def index
#     @orders = Order.all
#   end

#   # GET /orders/1 or /orders/1.json
#   def show
#   end

#   # GET /orders/new
#   def new
#     @order = Order.new
#   end

#   # GET /orders/1/edit
#   def edit
#   end

#   # POST /orders or /orders.json
#   def create
#     @order = Order.new(order_params)

#     respond_to do |format|
#       if @order.save
#         format.html { redirect_to order_url(@order), notice: "Order was successfully created." }
#         format.json { render :show, status: :created, location: @order }
#       else
#         format.html { render :new, status: :unprocessable_entity }
#         format.json { render json: @order.errors, status: :unprocessable_entity }
#       end
#     end
#   end

#   # PATCH/PUT /orders/1 or /orders/1.json
#   def update
#     respond_to do |format|
#       if @order.update(order_params)
#         format.html { redirect_to order_url(@order), notice: "Order was successfully updated." }
#         format.json { render :show, status: :ok, location: @order }
#       else
#         format.html { render :edit, status: :unprocessable_entity }
#         format.json { render json: @order.errors, status: :unprocessable_entity }
#       end
#     end
#   end

#   # DELETE /orders/1 or /orders/1.json
#   def destroy
#     @order.destroy

#     respond_to do |format|
#       format.html { redirect_to orders_url, notice: "Order was successfully destroyed." }
#       format.json { head :no_content }
#     end
#   end

#   private
#     # Use callbacks to share common setup or constraints between actions.
#     def set_order
#       @order = Order.find(params[:id])
#     end

#     # Only allow a list of trusted parameters through.
#     def order_params
#       params.require(:order).permit(:status)
#     end
# end

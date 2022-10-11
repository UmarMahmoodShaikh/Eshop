class AddressesController < ApplicationController
  # before_action :require_user
  before_action :set_address, only: %i[ show edit update destroy ]

  # GET /addresses or /addresses.json
  def index
    # client = Ignite::Client.new()
    # puts "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ #{client.query("SELECT name FROM SHOPPERS WHERE id = 3")} ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"

    @addresses = Address.where(shopper_id: Redis.current.get("shopper_id")).pluck(:id, :name)
    # url = "http://localhost:3000/api/v1/addresses/ShopperAddr?shopper_id=#{Redis.current.get("shopper_id")}"
    # response = 
  end

  # GET /addresses/1 or /addresses/1.json
  def show
  end

  # GET /addresses/new
  def new
    @address = Address.new
  end

  # GET /addresses/1/edit
  def edit
  end

  # POST /addresses or /addresses.json
  def create
    @address = Address.new(address_params)
    @address.shopper_id =Redis.current.get("shopper_id")
    respond_to do |format|
      if @address.save
        format.html { redirect_to address_url(@address), notice: "Address was successfully created." }
        format.json { render :show, status: :created, location: @address }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @address.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /addresses/1 or /addresses/1.json
  def update
    respond_to do |format|
      if @address.update(address_params)
        format.html { redirect_to address_url(@address), notice: "Address was successfully updated." }
        format.json { render :show, status: :ok, location: @address }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @address.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /addresses/1 or /addresses/1.json
  def destroy
    @address.destroy
    respond_to do |format|
      format.html { redirect_to addresses_url, notice: "Address was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_address
      address = Address.where(id: params[:id]).pluck(:id, :name, :detail, :shopper_id)
      if address[0][3] != Redis.current.get("shopper_id").to_i
        flash[:notice] = "You must be the same user as this address."
        redirect_to '/addresses'
      end
      Redis.current.mset("address_id","#{address[0][0]}","address_name","#{address[0][1]}","address_detail","#{address[0][2]}")
      puts "~~~~~~~~~~~~~~~~~~~~~ REDIS SAVED ADDRESS INFO #{address[0][3] }~~~~~~~~~~~~~~~~~~~~~"
      # client = Ignite::Client.new
      # @retailers = client.query("SELECT * FROM RETAILERS")
      @retailers = Retailer.all
    end

    # Only allow a list of trusted parameters through.
    def address_params
      params.require(:address).permit(:name, :detail)
    end
   

end

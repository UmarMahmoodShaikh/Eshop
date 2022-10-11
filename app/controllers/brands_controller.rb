class BrandsController < ApplicationController
  # before_action :require_user
  before_action :set_brand, only: %i[ show edit update destroy ]
  # GET /brands or /brands.json
  def index
    # postsavg= Post.all.average(:rate).to_i
    #  @posts=Post.all#.where(:rate => postsavg)
    @brands = Brand.where(company_id: Redis.current.get("company_id"))
  end
  # GET /brands/1 or /brands/1.json
  def show
    @brand = Brand.find(params[:id])
  end
  # GET /brands/new
  def new 
    @brand = Brand.new
  end
  # GET /brands/1/edit
  def edit
  end
  # POST /brands or /brands.json
  def create
    @brand = Brand.new(brand_params)
    # @brand[:company_id] = 99
    @brand.company_id = Redis.current.get("company_id")
    respond_to do |format|
      if @brand.save
        format.html { redirect_to brand_url(@brand), notice: "Brand was successfully created." }
        format.json { render :show, status: :created, location: @brand }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @brand.errors, status: :unprocessable_entity }
      end
    end
  end
  # PATCH/PUT /brands/1 or /brands/1.json
  def update
    respond_to do |format|
      if @brand.update(brand_params)
        format.html { redirect_to brand_url(@brand), notice: "Brand was successfully updated." }
        format.json { render :show, status: :ok, location: @brand }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @brand.errors, status: :unprocessable_entity }
      end
    end
  end
  # DELETE /brands/1 or /brands/1.json
  def destroy
    @brand = Brand.where(company_id: Redis.current.get("company_id"))
    $i = 0;
    while @brand[$i] != nil
      $t_id = @brand[$i].id.to_i
      Product.where(brand_id: $t_id).destroy_all
      $i +=1;
    end
    Brand.where(company_id: Redis.current.get("company_id")).destroy_all
    respond_to do |format|
      format.html { redirect_to brands_url, notice: "Brand was successfully destroyed." }
      format.json { head :no_content }
    end
  end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_brand
      @brand = Brand.find(params[:id])
      Redis.current.set("brand_id","#{@brand.id}")
      @product = Product.where(brand_id: Redis.current.get("brand_id"))
    end
    # Only allow a list of trusted parameters through.
    def brand_params
      params.require(:brand).permit(:name, :slogan)
    end
end

class CompaniesController < ApplicationController
  # before_action :require_user
  before_action :set_company, only: %i[ show edit update destroy]
  # GET /companies or /companies.json
  def index
    @companies = Company.all
    respond_to do |format|
      format.html  # index.html.erb
      format.json  { render :json => @companies }
    end
  end
  # GET /companies/1 or /companies/1.json
  def show
  end
  # GET /companies/new
  def new
    @company = Company.new
    respond_to do |format|
      format.html  # new.html.erb
      format.json  { render :json => @company }
    end
  end
  # GET /companies/1/edit
  def edit
    @company = Company.find(params[:id])
  end
  # POST /companies or /companies.json
  def create
    @company = Company.new(company_params)
    respond_to do |format|
      if @company.save
        format.html { redirect_to company_url(@company), notice: "Company was successfully created." }
        format.json { render :show, status: :created, location: @company }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @company.errors, status: :unprocessable_entity }
      end
    end
  end
  # PATCH/PUT /companies/1 or /companies/1.json
  def update
    respond_to do |format|
      if @company.update(company_params)
        format.html { redirect_to company_url(@company), notice: "Company was successfully updated." }
        format.json { render :show, status: :ok, location: @company }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @company.errors, status: :unprocessable_entity }
      end
    end
  end
  # DELETE /companies/1 or /companies/1.json
  def destroy
    # ABHI EK COMPANY KI MULTIPLE BRANDS KO DELETE HOI HAIN BS LEKIN UN MULTIPLE BRANDS KI MULTIPLE PRODUCTS NHI
    @brand = Brand.where(company_id: 99)
    $i = 0;
    while @brand[$i] != nil
      $t_id = @brand[$i].id.to_i
      Product.where(brand_id: $t_id).destroy_all
      $i +=1;
    end
    Brand.where(company_id: 99).destroy_all
    @company.destroy
    respond_to do |format|
      format.html { redirect_to companies_url, notice: "Company was successfully destroyed." }
      format.json { head :no_content }
    end
  end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_company
      @company = Company.find(params[:id])
    end
    # Only allow a list of trusted parameters through.
    def company_params
      params.require(:company).permit(:name, :about, :email)
    end
end
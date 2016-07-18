class BusinessesController < ApplicationController
  require 'CSV'
  skip_before_action :verify_authenticity_token

  before_action :set_business, only: [:show, :edit, :update, :destroy]

  # GET /businesses
  # GET /businesses.json
  def index
    @businesses = Business.all
  end

  def import
    begin
      @business   = Business.new
      parsed_file = CSV.read(params[:file].path, { :col_sep => "\t" })
      locations   = parsed_file[1..-1]
      
      begin
        @business.name_check(locations)
      rescue
        redirect_to root_url, notice: "Business names are not consistant in this file."
      end

      @business.name = parsed_file[1][0]
      @business.add_locations(locations)
      @business.save!

      redirect_to @business
  
    rescue
      redirect_to root_url, notice: "Invalid CSV file format."
    end
  end

  # GET /businesses/1
  # GET /businesses/1.json
  def show
    @business  = Business.find(params[:id])
    @locations = @business.locations.order(latitude: :asc, longitude: :asc)
  end

  # GET /businesses/new
  def new
    Business.import(params[:file])
    @business = Business.new
    @business.locations.build
  end

  # GET /businesses/1/edit
  def edit
  end

  # POST /businesses
  # POST /businesses.json
  def create
    binding.pry
    @business = Business.new(business_params)


    respond_to do |format|
      if @business.save
        format.html { redirect_to @business, notice: 'Business was successfully created.' }
        format.json { render :show, status: :created, location: @business }
      else
        format.html { render :new }
        format.json { render json: @business.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /businesses/1
  # PATCH/PUT /businesses/1.json
  def update
    respond_to do |format|
      if @business.update(business_params)
        format.html { redirect_to @business, notice: 'Business was successfully updated.' }
        format.json { render :show, status: :ok, location: @business }
      else
        format.html { render :edit }
        format.json { render json: @business.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /businesses/1
  # DELETE /businesses/1.json
  def destroy
    @business.destroy
    respond_to do |format|
      format.html { redirect_to businesses_url, notice: 'Business was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_business
      @business = Business.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def business_params
      # params.fetch(:business, {
      #   :name
      # })
      # address, city, state, postal code, country, latitude, longitude
      params.require(:business).permit(:name, locations_attributes: [:address, :city, :postal_code, :country, :latitude, :longitude])
    end
end

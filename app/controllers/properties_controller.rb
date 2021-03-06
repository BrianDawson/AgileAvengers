class PropertiesController < ApplicationController
  before_action :authenticate_user!, :except => [:index, :show]
  before_action :set_property, only: [:show, :edit, :update]
  # GET /properties
  # GET /properties.json
  def index
    


    case params[:search_type]
    when "Address"
      @properties = Property.find_all_by_query(params[:s])
    when "Zip"
      @properties = Property.find_all_by_zip(params[:s])
    when "Bedrooms"
      @properties = Property.find_all_by_bedroom(params[:s])     
    when "Bathrooms"
      @properties = Property.find_all_by_bathroom(params[:s])
    when "Rent"
      @properties = Property.find_all_by_rent(params[:s])
    when "Utilities"
      @properties = Property.find_all_by_utilities(params[:s])
    when "Pets"
      @properties = Property.find_all_by_pets(params[:s])
    else 
      @properties = Property.all
    end
  end
  
  # GET /properties/1
  # GET /properties/1.json
  def show
  end

  # GET /properties/new
  def new
    @property = Property.new
  end

  # GET /properties/1/edit
  def edit
  end

  # POST /properties
  # POST /properties.json
  def create
    @property = Property.new(property_params)

    respond_to do |format|
      if @property.save
        format.html { redirect_to @property, notice: 'Property was successfully created.' }
        format.json { render :show, status: :created, location: @property }
      else
        format.html { render :new }
        format.json { render json: @property.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /properties/1
  # PATCH/PUT /properties/1.json
  def update
    respond_to do |format|
      if @property.update(property_params)
        format.html { redirect_to @property, notice: 'Property was successfully updated.' }
        format.json { render :show, status: :ok, location: @property }
      else
        format.html { render :edit }
        format.json { render json: @property.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_property
      @property = Property.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def property_params
      params.require(:property).permit(:address, :city, :state, :zip, :bedrooms, :bathrooms, :rent, :pets, :utilities, :description)
    end
end

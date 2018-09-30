class HousesController < ApplicationController
  before_action :set_house, only: [:show, :edit, :update, :destroy]

  # GET /houses
  # GET /houses.json
  def index
    @houses = House.all
  end

  # GET /houses/1
  # GET /houses/1.json
  def show
  end

  def realtorhouses
    rel = Realtor.find_by(users_id: session[:user_id])
    @houses = House.where(realtor_id: rel.id)
    @company = Company.find(rel.companies_id).name
  end

  # GET /houses/new
  def new
    session[:previous_url] = request.referer
    @previous_url = request.referer
    @house = House.new
    if !session[:is_admin].nil? && session[:is_admin] == true
      @admin = true
      @companies = Company.all
    else
      realtor = Realtor.find_by(users_id: session[:user_id])
      if realtor.companies_id != nil
        @company = Company.find(realtor.companies_id).name
      else
        redirect_to session[:previous_url], notice: "invalid company"
      end
    end
  end

  # GET /houses/1/edit
  def edit
    @house = House.find(params[:id])
    if !session[:is_admin].nil? && session[:is_admin] == true
      @admin = true
      @companies = Company.all
    else
      realtor = Realtor.find_by(users_id: session[:user_id])
      if realtor.companies_id != nil
        @company = Company.find(realtor.companies_id).name
      else
        redirect_to session[:previous_url], notice: "invalid company"
      end
    end
    if @house.realtor_id != Realtor.find_by(users_id: session[:user_id]).id
      redirect_to houses_path, notice: "You cannot edit listing you have not posted"
    end
    # todo: Delete extra tables in migrations
  end

  # POST /houses
  # POST /houses.json
  def create
    @house = House.new(house_params)
    realtor_id = Realtor.find_by(users_id: session[:user_id])
    @house.realtor_id = realtor_id.id
    @house.companies_id = Company.find(realtor_id.companies_id).id
    respond_to do |format|
      if @house.save
        format.html {redirect_to houses_path, notice: 'House was successfully created.'}
        format.json {render :show, status: :created, location: @house}
      else
        format.html {redirect_to houses_path, notice: 'Error saving house'}
        format.json {render json: @house.errors, status: :unprocessable_entity}
      end
    end
  end

  # PATCH/PUT /houses/1
  # PATCH/PUT /houses/1.json
  def update
    respond_to do |format|
      if @house.update(house_params)
        format.html {redirect_to @house, notice: 'House was successfully updated.'}
        format.json {render :show, status: :ok, location: @house}
      else
        format.html {render :edit}
        format.json {render json: @house.errors, status: :unprocessable_entity}
      end
    end
  end

  # DELETE /houses/1
  # DELETE /houses/1.json
  def destroy
    @house.destroy
    respond_to do |format|
      format.html {redirect_to houses_url, notice: 'House was successfully destroyed.'}
      format.json {head :no_content}
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_house
    @house = House.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def house_params
    params.require(:house).permit(:realtor_id, :companies_id, :location, :area, :year_built, :style, :list_prize, :floor_count, :basement, :owner_name)
  end
end

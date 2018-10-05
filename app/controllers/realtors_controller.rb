class RealtorsController < ApplicationController
  before_action :set_realtor, only: [:show, :edit, :update, :destroy]

  # GET /realtors
  # GET /realtors.json
  def index
    if session[:role] != "admin"
      redirect_to login_path, notice: "You cannot access the page"
    end
    @realtors = Realtor.all
  end

  # GET /realtors/1
  # GET /realtors/1.json
  def show
    @realtor = Realtor.find(params[:id])
    if @realtor.companies_id != nil
      @company = Company.find(@realtor.companies_id)
    end
  end

  # GET /realtors/new
  def new
    @realtor = Realtor.new
  end

  # GET /realtors/1/edit
  def edit
    @realtor = Realtor.find(params[:id])
    @selected = 2
    @companies = Company.all
    if @realtor.companies_id != nil
      @company = @realtor.companies_id
    end
  end

  # POST /realtors
  # POST /realtors.json
  def create
    @realtor = Realtor.new(realtor_params)
    @user = User.new(user_params)
    @user.is_realtor = true
    respond_to do |format|
      if @user.save
        @realtor.users_id = @user.id
        if @realtor.save
          format.html {redirect_to @realtor, notice: 'Realtor was successfully created.'}
          format.json {render :show, status: :created, location: @realtor}
        else
          format.html {render :new}
          format.json {render json: @realtor.errors, status: :unprocessable_entity}
        end
      else
        format.html {render :new}
        format.json {render json: @user.errors, status: :unprocessable_entity}
      end
    end
  end

  # PATCH/PUT /realtors/1
  # PATCH/PUT /realtors/1.json
  def update
    respond_to do |format|
      if @realtor.update(realtor_params)
        format.html {redirect_to @realtor, notice: 'Realtor was successfully updated.'}
        format.json {render :show, status: :ok, location: @realtor}
      else
        format.html {render :edit}
        format.json {render json: @realtor.errors, status: :unprocessable_entity}
      end
    end
  end

  # DELETE /realtors/1
  # DELETE /realtors/1.json
  def destroy
    @realtor.destroy
    respond_to do |format|
      format.html {redirect_to realtors_url, notice: 'Realtor was successfully destroyed.'}
      format.json {head :no_content}
    end
  end
  def potential
    #session[:previous_url] = request.referer
    rel = Realtor.find_by(users_id: session[:user_id])
    puts rel.id
    @com = Company.find(rel.companies_id)
    @house = House.where(:companies_id=>@com.id)
    #hh = Hash.new
    fh=Hash.new
    @fu=Hash.new
    i=0
    j=0
    puts @house
    @house.each do |h|

      hh=InterestedHousehunter.where(:house_id => h[:id])
      unless hh.empty?
        @fu[i]=Househunter.where(:id=>hh[0][:househunter_id])
       i=i+1
        end
      #fh[i]={h.id=>h,hh[h.id][:househunter_id]=>fu[hh[h.id][:househunter_id]]}
      #i=i+1
    end
    #@househunters=Househunter.find_by()
  end
  private

  # Use callbacks to share common setup or constraints between actions.
  def set_realtor
    @realtor = Realtor.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def realtor_params
    params.require(:realtor).permit(:first_name, :last_name, :companies_id, :phone_number, :user_id )
  end

  #Allows saving of user from within realtors controller.
  def user_params
    params.require(:user).permit(:email_id, :password, :is_admin, :is_realtor, :is_househunter)
  end

end

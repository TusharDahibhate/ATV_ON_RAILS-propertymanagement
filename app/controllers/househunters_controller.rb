class HousehuntersController < ApplicationController
  before_action :set_househunter, only: [:show, :edit, :update, :destroy]

  # GET /househunters
  # GET /househunters.json
  def index
    @househunters = Househunter.all
  end

  # GET /househunters/1
  # GET /househunters/1.json
  def show
  end

  # GET /househunters/new
  def new
    @househunter = Househunter.new
  end

  # GET /househunters/1/edit
  def edit
  end

  # POST /househunters
  # POST /househunters.json
  def create
    @househunter = Househunter.new(househunter_params)
    @user = User.new(user_params)
    @user.is_househunter = true

    respond_to do |format|
      if @user.save
        if @househunter.save
          format.html {redirect_to @househunter, notice: 'Househunter was successfully created.'}
          format.json {render :show, status: :created, location: @househunter}
        else
          format.html {render :new}
          format.json {render json: @househunter.errors, status: :unprocessable_entity}
        end
      else
        format.html {render :new}
        format.json {render json: @user.errors, status: :unprocessable_entity}
      end
    end
  end

  # PATCH/PUT /househunters/1
  # PATCH/PUT /househunters/1.json
  def update
    respond_to do |format|
      if @househunter.update(househunter_params)
        format.html {redirect_to @househunter, notice: 'Househunter was successfully updated.'}
        format.json {render :show, status: :ok, location: @househunter}
      else
        format.html {render :edit}
        format.json {render json: @househunter.errors, status: :unprocessable_entity}
      end
    end
  end

  # DELETE /househunters/1
  # DELETE /househunters/1.json
  def destroy
    @househunter.destroy()
    respond_to do |format|
      format.html {redirect_to househunters_url, notice: 'Househunter was successfully destroyed.'}
      format.json {head :no_content}
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_househunter
    @househunter = Househunter.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def househunter_params
    params.require(:househunter).permit(:first_name, :last_name, :phone, :contact_method, :users_id)
  end

  def user_params
    params.require(:user).permit(:email_id, :password, :is_admin, :is_realtor, :is_househunter)
  end
end

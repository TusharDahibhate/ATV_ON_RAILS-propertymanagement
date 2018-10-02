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
    @user = User.find(@househunter.users_id)
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
        @househunter.users_id = @user.id
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

  def input

  end

  def search
    str = ""
    if params[:location] != nil && params[:location] != ""
      if str.empty?
        str = str + " location = '#{params[:location]}'"
      else
        str = str + "AND location = '#{params[:location]}' "
      end
    end
    if params[:area] != nil && params[:area] != ""
      if str.empty?
        str = str + " area = #{params[:area]} "
      else
        str = str + " AND area = #{params[:area]}  "
      end
    end
    if params[:year_built] != nil && params[:year_built] != ""
      if str.empty?
        str = str + " year_built = #{params[:year_built]} "
      else
        str = str + " AND year_built = #{params[:year_built]} "
      end
    end
    if params[:style] != nil && params[:style] != ""
      if str.empty?
        str = str + " style = '#{params[:style]}' "
      else
        str = str + " AND style = '#{params[:style]}' "
      end
    end
    if params[:list_prize] != nil && params[:list_prize] != ""
      if str.empty?
        str = str + " list_prize = #{params[:list_prize]} "
      else
        str = str + " AND list_prize = #{params[:list_prize]} "
      end
    end
    if params[:floor_count] != nil && params[:floor_count] != ""
      if str.empty?
        str = str + " floor_count = #{params[:floor_count]} "
      else
        str = str + " AND floor_count = #{params[:floor_count]} "
      end
    end
    if params[:basement] != nil && params[:basement] != ""
      if str.empty?
        str = str + " basement=#{params[:basement]} "
      else
        str = str + " AND basement=#{params[:basement]} "
      end
    end
    if params[:owner_name] != nil && params[:owner_name] != ""
      if str.empty?
        str = str + " owner_name='#{params[:owner_name]}' "
      else
        str = str + " AND owner_name='#{params[:owner_name]}' "
      end
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

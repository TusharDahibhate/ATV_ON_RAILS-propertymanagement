class InquiriesController < ApplicationController
  before_action :set_inquiry, only: [:show, :edit, :update, :destroy]

  # GET /inquiries
  # GET /inquiries.json
  def index
    @inquiries = Inquiry.all
  end

  # GET /inquiries/1
  # GET /inquiries/1.json
  def show
  end

  # GET /inquiries/new
  def new
    @houseid = params[:id]
    @househunterid = Househunter.find_by(:users_id => session[:user_id])
    @inquiry = Inquiry.new

  end

  # GET /inquiries/1/edit
  def edit
  end

  # POST /inquiries
  # POST /inquiries.json
  def create

    @househunter = Househunter.find_by(:id => inquiry_params[:user_id])
    @inquiry = Inquiry.new(:househunters_id => inquiry_params[:user_id], :houses_id => inquiry_params[:house_id], :content => inquiry_params[:content], :subject => inquiry_params[:subject])

    respond_to do |format|
      if @inquiry.save
        format.html {redirect_to house_path(@househunter), notice: 'Inquiry was successfully created.'}
      else
        format.html {redirect_to request.referer, notice: 'Error'}
      end
    end
  end

  # PATCH/PUT /inquiries/1
  # PATCH/PUT /inquiries/1.json
  def update
    respond_to do |format|
      if @inquiry.update(inquiry_params)
        format.html { redirect_to @inquiry, notice: 'Inquiry was successfully updated.' }
        format.json { render :show, status: :ok, location: @inquiry }
      else
        format.html { render :edit }
        format.json { render json: @inquiry.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /inquiries/1
  # DELETE /inquiries/1.json
  def destroy
    @inquiry.destroy
    respond_to do |format|
      format.html { redirect_to inquiries_url, notice: 'Inquiry was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_inquiry
      @inquiry = Inquiry.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def inquiry_params
      params.require(:inquiry).permit(:subject, :content, :user_id, :house_id)
    end
end

class ApplicationController < ActionController::Base
  def verify_logged_in
    if request.fullpath != login_path && session[:logged_in] != "true"
      redirect_to login_path, notice:"Please log in first"
    end
  end

  before_action :verify_logged_in
end
class ApplicationController < ActionController::Base
  before_action :set_previous_page_location
  def set_previous_page_location
    session[:previous_url] = request.referer
  end
end
# frozen_string_literal: true

class LoginController < ApplicationController
  def new
    if session[:user_id] != nil
      redirect_to user_path(session[:user_id])
    end
  end

  def create
    user = User.find_by(email_id: params[:login][:email].downcase)
    if user && user.password == params[:login][:password]
      session[:user_id] = user.id
      session[:logged_in] = 'true'
      session[:is_admin] = user.is_admin
      session[:is_realtor] = user.is_realtor
      session[:is_househunter] = user.is_househunter
      redirect_to user
    else
      respond_to do |format|
        format.html {redirect_to login_path, flash: {error: 'Invalid Credentials'}}
      end
    end
  end

  def destroy
   reset_session
    redirect_to login_path
  end
end

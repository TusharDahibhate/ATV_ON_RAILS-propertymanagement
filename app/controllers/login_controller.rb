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

      if user.is_admin != nil && user.is_admin == true
        session[:is_admin] = true
        if params[:login][:role] == "admin"
          session[:role] = params[:login][:role]
        end
        redir = "/admin"
      elsif user.is_realtor != nil && user.is_realtor == true
        session[:is_realtor] = true
        if params[:login][:role] == "realtor"
          session[:role] = params[:login][:role]
        end
        redir = realtor_path(Realtor.find_by(users_id: user.id).id)
      elsif user.is_househunter != nil && user.is_househunter == true
        session[:is_househunter] = true
        if params[:login][:role] == "househunter"
          session[:role] = params[:login][:role]
        end
        redir = househunter_path(Househunter.find_by(users_id: user.id).id)
      end

      if session[:role] == nil
        redir = login_path
        reset_session
        flash.notice = "You have not registered for that role"
      end

      redirect_to redir
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

# frozen_string_literal: true
# todo: project limitation at : https://docs.google.com/document/d/128QlWRbpKavWIGBwq1zc4BUGBfW8S0b535kLORIHn4Y/edit?usp=sharing
# todo : Restrict - Househunter login gives access to realtor pages too.

class LoginController < ApplicationController
  def new
    if session[:role] != nil && session[:role] == "admin"
      redir = admin_path
      fl = true
    end
    if session[:user_id] != nil
      redir = user_path(session[:user_id])
      fl = true
    end
    if fl == true
      redirect_to redir
    end
  end

  def create
    # Verify if admin
    if params[:login][:email] == 'admin@admin' && params[:login][:password] == 'admin'
      session[:is_admin] = true
      session[:role] = 'admin'
      session[:logged_in] = true
      redir = admin_path
    else
      # If not admin, set appropriate levels
      user = User.find_by(email_id: params[:login][:email].downcase)
      if user && user.password == params[:login][:password]
        session[:user_id] = user.id
        session[:logged_in] = true

        # Check user role and set parameters
        if user.is_realtor != nil && user.is_realtor == true
          session[:is_realtor] = true
          # Verify that user is trying to login as a realtor
          # Without the following condition, trying to log in as realtor with
          # correct househunter credentials will also work and
          # will set role as realtor even if user wants to login as husehunter
          if params[:login][:role] == 'realtor'
            session[:role] = params[:login][:role]
          end
          redir = realtor_path(Realtor.find_by(users_id: user.id).id)
        elsif user.is_househunter != nil && user.is_househunter == true
          session[:is_househunter] = true
          if params[:login][:role] == 'househunter'
            session[:role] = params[:login][:role]
          end
          redir = househunter_path(Househunter.find_by(users_id: user.id).id)
        end
      else
        respond_to do |format|
          format.html {redirect_to login_path, flash: {error: 'Invalid Credentials'}} and return
        end
      end
    end
    if session[:role] == nil
      redir = login_path
      reset_session
      flash.notice = 'Please select a role that you are registered for.'
    end
    redirect_to redir
  end

  def destroy
    reset_session
    redirect_to login_path
  end
end

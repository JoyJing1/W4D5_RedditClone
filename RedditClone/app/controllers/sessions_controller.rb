class SessionsController < ApplicationController

    def new
      render :new
    end

    def create
      @user = User.find_by_credentials(
        params[:user][:username],
        params[:user][:password]
      )

      if @user.nil?
        flash.now[:errors] = ["Invalid Credentials"]
        render :new
      else
        login!(@user)
        redirect_to user_url(@user)
      end
    end

    def destroy
      current_user.reset_session_token!
      session[:session_token] = nil
      redirect_to new_session_url
    end



end

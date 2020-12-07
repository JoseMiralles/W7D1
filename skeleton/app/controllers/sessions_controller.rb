class SessionsController < ApplicationController

    def new
        render :new
    end

    def create
        user = User.find_by_credentials(
            params[:user][:username],
            params[:user][:password]
            )
        if user
            session[:session_token] = user.reset_session_token!
            redirect users_url
        else
            flash.now[:errors] = "Invalid credentials."
            render :new
        end
    end

    def destroy
        
    end

end
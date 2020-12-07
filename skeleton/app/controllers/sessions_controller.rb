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
            login_user!(user)
            redirect users_url
        else
            flash.now[:errors] = "Invalid credentials."
            render :new
        end
    end

    def destroy 
        logout!
        redirect_to new_session_url
    end

end
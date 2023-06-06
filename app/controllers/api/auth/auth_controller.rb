class Api::Auth::AuthController < ApplicationController
    def login
        user = User.find_by(:username => params[:username])
        
        # if username not exist
        if user.nil?
            render json: {msg: "Username doesn't exist"}, status: :unprocessable_entity
            return true
        end
        
        #if username exist
        if user.authenticate(params[:password])
            render json: {msg: "Success Login", data: user.successful_response}, status: :ok
        else
            render json: {msg: "Password wrong"}, status: :unprocessable_entity
        end

    end
end

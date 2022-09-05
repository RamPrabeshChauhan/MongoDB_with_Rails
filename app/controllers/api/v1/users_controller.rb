class Api::V1::UsersController < ApplicationController

    def getUsers

    end

    def addUser
        user = User.new(username: params[:username], email: params[:email], password_digest: params[:password])

        if user.save()
            render json: user, status: :ok
        else
            render json: {message: "User not added"}, status: :unprocessable_entity
        end
        
    end 
    
end
 
class Api::V1::UsersController < ApplicationController

    before_action :userId, only: [:showUser, :updateUser, :deleteUser]

    # ─── Get ────────────────────────────────────────────────────────────────────────
    def getUsers
        user = User.all
        if user
            formatted_users = user.map do |userValue|
                {
                    id: userValue["_id"].to_s,
                    username: userValue["username"].strip, 
                    email: userValue["email"],
                }
            end
            render json: formatted_users, status: :ok
        else
            render json: {message: "No user found."}, status: :unprocessable_entity
        end

    end

    # ─── Post ───────────────────────────────────────────────────────────────────────
    def addUser
        user = User.new(username: params[:username], email: params[:email], password: params[:password])

        if user.save()
            render json: user.successful_response, status: :ok
        else
            render json: {message: "User not added", error: user.errors }, status: :unprocessable_entity
        end
         
    end 

    # ─── Show ───────────────────────────────────────────────────────────────────────
    def showUser
        if @user  
            formatted_users = {
                id: @user["_id"].to_s,
                username: @user["username"].strip,
                email: @user["email"],
              }
            render json: formatted_users, status: :ok
        else
            render json: {message: "User not found.."}, status: :unprocessable_entity
        end
    end

    # ─── Put ────────────────────────────────────────────────────────────────────────
    def updateUser
        if @user
            if @user.update(username: params[:username], email: params[:email], password: params[:password])
                render json: @user.successful_response, status: :ok
            else
                render json: {message: "Failed to update user.", error: @user.errors }, status: :unprocessable_entity
            end
        else
            render json: {message: "User not found.."}, status: :unprocessable_entity
        end
    end
    

    # ─── Delete ─────────────────────────────────────────────────────────────────────
    def deleteUser
        if @user
            if @user.destroy(username: params[:username], email: params[:email], password: params[:password])
                render json: {message: "User deleted successfully!"}, status: :ok
            else
                render json: {message: "Failed to delete user."}, status: :unprocessable_entity
            end
        else
            render json: {message: "User not found...", }, status: :unprocessable_entity
        end
    end
    
    # passing user id 
    private
        def userId
            @user = User.find(params[:id])
        end
    
end
 
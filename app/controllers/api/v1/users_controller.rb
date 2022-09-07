class Api::V1::UsersController < ApplicationController

    before_action :userId, only: [:showUser, :updateUser, :deleteUser]

    # ─── Get ────────────────────────────────────────────────────────────────────────
    def getUsers
        user = User.all
        if user
            render json: user, status: :ok
        else
            render json: {message: "User Empty"}, status: :unprocessable_entity
        end

    end

    # ─── Post ───────────────────────────────────────────────────────────────────────
    def addUser
        user = User.new(username: params[:username], email: params[:email], password: params[:password])

        if user.save()
            render json: user, status: :ok
        else
            render json: {message: "User not added", error: user.errors }, status: :unprocessable_entity
        end
        
    end 

    # ─── Show ───────────────────────────────────────────────────────────────────────
    def showUser
        if @user
                render json: @user, status: :ok
        else
            render json: {message: "User not found.."}, status: :unprocessable_entity
        end
    end

    # ─── Put ────────────────────────────────────────────────────────────────────────
    def updateUser
        if @user
            if @user.update(username: params[:username], email: params[:email], password: params[:password])
                render json: @user, status: :ok
            else
                render json: {message: "User failed", error: @user.errors }, status: :unprocessable_entity
            end
        else
            render json: {message: "User not found.."}, status: :unprocessable_entity
        end
    end
    

    # ─── Delete ─────────────────────────────────────────────────────────────────────
    def deleteUser
        if @user
            if @user.destroy(username: params[:username], email: params[:email], password: params[:password])
                render json: {message: "User deleted"}, status: :ok
            else
                render json: {message: "User failed"}, status: :unprocessable_entity
            end
        else
            render json: {message: "User not found..", }, status: :unprocessable_entity
            # render json: @user, status: :unprocessable_entity
        end
    end
    
    # passing user id 
    private
        def userId
            @user = User.find(params[:id])
        end
    
end
 
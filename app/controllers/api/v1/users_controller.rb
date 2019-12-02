class Api::V1::UsersController < ApplicationController
  def create
    user = User.new(user_params)
    #@user.create_pick_history
    if user.save
      render json: {message: "User successfully created!", user: user, status: 201}
    else
      render json: {
        message: {
          errors: user.errors.full_messages,
        }
      }
    end
  end

  def login
    user = User.find_by(:username => params[:username])
    if user 
      render json: user
    else 
      render json: {message: "You could not be logged in!"}
    end
  end


  private

  def user_params
    params.require(:user).permit(:username, :email)
  end
end
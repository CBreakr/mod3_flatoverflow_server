class UsersController < ApplicationController
  def index
    users = User.all
    render json: users
  end

  def show
    user = User.find_by(id: params[:id])
    render json: user
  end

  def create
    # byebug
    user = User.create(user_params)
  end

  private 

  def user_params
    params.require(:user).permit(:name, :is_coach)
  end
end

class UsersController < ApplicationController
  def index
    users = User.all
    puts users
    render json: users, methods: :score
  end

  def show
    user = User.find_by(id: params[:id])
    render json: user, methods: :score
  end

  def create
    # byebug
    user = User.create(user_params)
    render json: user, methods: :score
  end

  private 

  def user_params
    params.require(:user).permit(:name, :is_coach)
  end
end

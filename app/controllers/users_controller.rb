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
<<<<<<< HEAD
    render json: user
=======
    render json: user, methods: :score
>>>>>>> 441c95e6145125725ba133a6fe3809759b7e6e37
  end

  private 

  def user_params
    params.require(:user).permit(:name, :is_coach)
  end
end

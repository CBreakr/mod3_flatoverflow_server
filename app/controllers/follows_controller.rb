class FollowsController < ApplicationController
  def index
    follows = Follow.all 
    render json: follows 
  end

  def create
    # byebug
    follow = Follow.find_or_create_by(follower_id: follow_params[:follower_id], followee_id: follow_params[:followee_id])
    render json: follow
  end

  private

  def follow_params
    params.require(:follow).permit(:follower_id, :followee_id)
  end
end

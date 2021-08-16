class RelationshipsController < ApplicationController
  
  def index
    #@user = User.where.not(id: current_user.id)
    user = User.find(params[:id])
    @user = user.follower.all
  end
  
  def create
    current_user.follow(params[:id])
    redirect_to request.referer
  end
  
  def destroy
    current_user.unfollow(params[:id])
    redirect_to request.referer
  end
  
end

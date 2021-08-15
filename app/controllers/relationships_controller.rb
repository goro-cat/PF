class RelationshipsController < ApplicationController
  
  def index
    @user = User.all
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

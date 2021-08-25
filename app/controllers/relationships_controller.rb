class RelationshipsController < ApplicationController
  # def index
  #  @user = User.where.not(id: current_user.id).page(params[:page]).reverse_order
  # @user = User.follower.all
  # end

  def create
    user = User.find(params[:user_id])
    current_user.follow(params[:user_id])
    # フォローしたとき通知発射！
    user.create_notification_follow!(current_user)
    redirect_to request.referer
  end

  def destroy
    current_user.unfollow(params[:user_id])
    redirect_to request.referer
  end

  def followings
    user = User.find(params[:user_id])
    @users = user.followings
  end

  def followers
    user = User.find(params[:user_id])
    @users = user.followers
  end
end

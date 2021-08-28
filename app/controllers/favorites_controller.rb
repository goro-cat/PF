class FavoritesController < ApplicationController
  before_action :authenticate_user!
  
  def index
  #  @posts = Post.where(params[:id])
    @user = User.find(params[:id])
    favorites = Favorite.where(user_id: @user.id).pluck(:post_id)
    @favorite_posts = Post.find(favorites)
  end

  def create
    @post = Post.find(params[:post_id])
    favorite = current_user.favorites.new(post_id: @post.id)
    favorite.save
    # redirect_to request.referer
  end

  def destroy
    @post = Post.find(params[:post_id])
    favorite = current_user.favorites.find_by(post_id: @post.id)
    favorite.destroy
    # redirect_to request.referer
  end

  private

  def post_params
    params.require(:post).permit(:post_id)
  end
end

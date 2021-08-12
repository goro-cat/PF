class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @posts = Post.where(user_id: current_user)
  end

  def edit
  end

  private
  def user_params
    params.require(user).permit(:account_name, :address)
  end

  def post_params
    params.require(:post).permit(:post_image_id, :text, :plase, :pet_name, :pet_sex)
  end

end

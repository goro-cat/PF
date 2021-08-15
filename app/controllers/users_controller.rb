class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @posts = Post.where(user_id: current_user)
  end

  def edit
    @user = User.find(params[:id])
  end
  
  def update
    user = User.find(params[:id])
    user.update(user_params)
    redirect_to user_path(user.id)
  end

  private
  def user_params
    params.require(:user).permit(:email, :last_name, :first_name, :kana_last_name, :kana_first_name, :account_name, :account_image, :address, :phone_number, :introduction)
  end

  def post_params
    params.require(:post).permit(:post_image_id, :text, :plase, :pet_name, :pet_sex)
  end

end

class PostsController < ApplicationController
  before_action :authenticate_user!, except: %i[search protect retrieval]

  def new
    @post = Post.new
  end

  def show
    @post = Post.find(params[:id])
    @user = @post.user
    @unchecked_notifications = Notification.where(visited_id: current_user.id, cheacked: false)
    @comment = Comment.new
  end

  def create
    # postにuser_idを持たせる必要があるため、current_userを追記
    @post = current_user.posts.create(post_params)

    if @post.save
      flash[:notice] = '投稿できました'
      redirect_to post_path(@post)
    else
      flash[:danger] = '投稿ができませんでした'
      render :new
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = current_user.posts.find(params[:id])

    if @post.update(post_params)
      flash[:notice] = '投稿できました'
      redirect_to post_path(@post)
    else
      flash[:danger] = '投稿ができませんでした'
      render :edit
    end
  end

  def destroy
    @post = current_user.posts.find(params[:id])
    if @post.destroy
      flash[:notice] = '投稿を削除しました'
      redirect_to user_path(@post.user_id)
    else
      flash[:danger] = '投稿の削除に失敗しました'
      redirect_to request referer
    end
  end

  def search
    @posts = Post.where(category: 0).page(params[:page]).per(12)
    @keyword = params[:keyword]
  end

  def protect
    @posts = Post.where(category: 1).page(params[:page]).per(12)
    @keyword = params[:keyword]
  end

  def retrieval
    @posts = Post.retrieval(params[:keyword])

    @search_posts = @posts.where(category: 0).page(params[:page]).per(5)
    @protect_posts = @posts.where(category: 1).page(params[:page]).per(5)

    @keyword = params[:keyword]
  end

  private

  def post_params
    params.require(:post).permit(
      :text,
      :pet_name,
      :plase,
      :pet_sex,
      :category,
      :animal,
      :id,
      post_images_images: []
    )
  end
end

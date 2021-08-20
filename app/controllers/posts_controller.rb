class PostsController < ApplicationController

  def index
    @posts = Post.page(params[:page]).per(5)
   # if Post.find(category: 1)?
     # @posts = Post.where(category: 1).page(params[:page]).per(10)
   # else
     # @posts = Post.where(category: 2).page(params[:page]).per(10)
  #  end
  end

  def new
    @post = Post.new

  end

  def show
    @post = Post.find(params[:id])
    @comment = Comment.new
  end

  def create
    #postにuser_idを持たせる必要があるため、current_userを追記
    @post = current_user.posts.create(post_params)

    if @post.save!
      redirect_to post_path(@post)
    else
      render :new
    end

  end

  def update
    @form = Post.new(post_params, post: @post)

    if @form.update
      redirect_to post_path(@form.id)
    else
      render :edit
    end
  end


  def search
   # @post = params[:]



    @posts = Post.all.search(params[:keyword])
    @keyword = params[:keyword]
    render "index"
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
      post_images_images:[]
      )
  end

end

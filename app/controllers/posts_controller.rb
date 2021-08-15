class PostsController < ApplicationController

  def new
    @genre = Genre.new
    @genre.posts.build
    #@post = @genre.posts.new
  end

  def create
    @genre = Genre.new(genre_params)
    if @genre.save
      redirect_to post_path(@genre.user_id)
    else
      render "new"
    end

     # genre = Genre.new(genre_params)
     #genre.save

     #  post = Post.new(post_params)
    #  post.save
    #  redirect_to post_path(post.id)
  end

  def index
    #@posts = Genre.all.includes(:posts)
    @posts = Post.all
  end

  def show
    #genre = Genre.find(params[:id])
    @post = Post.find(genre_params.podt_attributes[:id])
    
  end

  def edit
  end

  def destroy
  end

  private
  def genre_params
    params.require(:genre).permit(:category, :animal, [posts_attributes: [:pet_sex, :text, :plase, :post_image, :pet_name]]).merge(user_id: current_user.id)
  end


  #def post_params
  #　 params.require(:post).permit(:genre_id, :pet_sex, :text, :plase, :post_image, :pet_name)
  #end
end

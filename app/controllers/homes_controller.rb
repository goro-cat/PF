class HomesController < ApplicationController
  def top
    # @search = Post.where(category: 'search')
    # @search_list = @search.first(5)

    @search_post = Post.where(category: 0).page(params[:page]).per(3)
    @protect_post = Post.where(category: 1).page(params[:page]).per(3)
  end
end

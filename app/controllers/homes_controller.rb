class HomesController < ApplicationController

  def top
    @search = Post.where(category: 'search')
    @search_list = @search.first(5)
    #@search_item = @search.order(:created_at)
    #@search_latest5 = @search_item.first(5)

  end
end

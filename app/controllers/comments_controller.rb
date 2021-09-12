class CommentsController < ApplicationController


  def create
    post_comment = Post.find(params[:post_id])
    @comment = current_user.comments.new(comment_params)
    @comment.post_id = post_comment.id
    @post = @comment.post

    if @comment.save
      # post.rbに記述したメソッドで通知を発射！
      @post.create_notification_comment!(current_user, @comment.id)
      #redirect_to request.referer
    else
      #redirect_to post_path(post_comment)
    end
  end

  def destroy
    Comment.find_by(id: params[:id], post_id: params[:post_id]).destroy
    redirect_to post_path(params[:post_id])
  end

  private

  def comment_params
    params.require(:comment).permit(:post_id, :comment)
  end
end

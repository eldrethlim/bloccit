# app/controllers/comments_controller.rb

class CommentsController < ApplicationController

  def new
    @post = Post.find(params[:post_id])
    @comment = Comment.new
    authorize @comment
  end

  def create
    @post = Post.find(params[:post_id])
    @comment = current_user.comments.build(comment_params)
    @comment.post = @post

    authorize @comment
    if @comment.save
      redirect_to [@post.topic, @post], notice: "You successfully commented on this post."
    else
      flash[:error] = "There was an error commenting on this post. Please try again."
      render :new
    end
  end

  def edit
    @post = Post.find(params[:post_id])
    @comment = Comment.find(params[:id])
    authorize @comment
  end

  def update
    @post = Post.find(params[:post_id])
    @comment = Comment.find(params[:id])
    authorize @comment
    if @comment.update_attributes(comment_params)
      flash[:notice] = "Your comment was updated."
      redirect_to [@post]
    else
      flash[:error] = "There was an error updating your comment. Please try again."
      render :edit
    end
  end

  def comment_params
    params.require(:comment).permit(:body, :image)
  end 
end
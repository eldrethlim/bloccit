# app/controllers/topics/posts_controller.rb

class Topics::PostsController < ApplicationController

  def new
    @topic = Topic.find(params[:topic_id])
    @post = Post.new
    authorize @post
  end

  def create
    @topic = Topic.find(params[:topic_id])
    @post = current_user.posts.build(post_params)
    @post.topic = @topic

    authorize @post
    if @post.save
      redirect_to [@topic, @post], notice: "You successfully created a new post."
    else
      flash[:error] = "There was an error saving your post. Please try again."
      render :new
    end
  end
  
  def show
    @post = Post.find(params[:id])
    @topic = Topic.find(params[:topic_id])
    authorize @topic
    @comment = @post.comments.build
    @comments = @post.comments.paginate(page: params[:page], per_page: 10)
  end

  def edit
    @topic = Topic.find(params[:topic_id])
    @post = Post.find(params[:id])
    authorize @post
  end

  def update
    @topic = Topic.find(params[:topic_id])
    @post = Post.find(params[:id])
    authorize @post
    if @post.update_attributes(post_params)
      flash[:notice] = "Your post was updated."
      redirect_to [@topic, @post]
    else
      flash[:error] = "There was an error updating your post. Please try again."
      render :edit
    end
  end

  def destroy
    @topic = Topic.find(params[:topic_id])
    @post = Post.find(params[:id])

    title = @post.title
    authorize @post
    if @post.destroy
      flash[:notice] = "\"#{title}\" was deleted successfully."
      redirect_to @topic
    else
      flash[:error] = "There was an error deleting this post."
      render :show
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :body, :image)
  end
end

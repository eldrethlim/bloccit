class FavouritesController < ApplicationController
  def create
    @topic = Topic.find(params[:topic_id])
    @post = @topic.posts.find(params[:post_id])
    favourite = current_user.favourites.build(post: @post)

    authorize favourite

    if favourite.save
      flash[:notice] = "Favourited post"
      redirect_to [@topic, @post]
    else
      flash[:error] = "Error trying to favourite post. Please try again."
      redirect_to [@topic, @post]
    end
  end

  def destroy
    @topic = Topic.find(params[:topic_id])
    @post = @topic.posts.find(params[:post_id])
    favourite = current_user.favourites.find(params[:id])

    authorize favourite

    if favourite.destroy
      flash[:notice] = "Removed favourite."
      redirect_to [@topic, @post]
    else
      flash[:error] = "Error removing favourite from post. Please try again"
      redirect_to [@topic, @post]
    end
  end
end
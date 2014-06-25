# app/Controllers/votes_controller.rb

class VotesController < ApplicationController

  def p_up_vote
    p_vote_setup
    p_update_vote(1)

    redirect_to :back
  end

  def p_down_vote
    p_vote_setup 
    p_update_vote(-1)

    redirect_to :back
  end

  def c_up_vote
    c_vote_setup
    c_update_vote(1)

    redirect_to :back
  end

  def c_down_vote
    c_vote_setup
    c_update_vote(-1)

    redirect_to :back
  end

  private

  def p_update_vote(new_value)
    if @vote
      authorize @vote, :update?
      @vote.update_attribute(:value, new_value)
    else
      @vote = current_user.votes.build(value: new_value, post: @post)
      authorize @vote, :create?
      @vote.save
    end
  end

  def c_update_vote(new_value)
    if @vote
      authorize @vote, :update?
      @vote.update_attribute(:value, new_value)
    else
      @vote = current_user.votes.build(value: new_value, comment: @comment)
      authorize @vote, :create?
      @vote.save
    end
  end

  def p_vote_setup
    @topic = Topic.find(params[:topic_id])
    @post = @topic.posts.find(params[:post_id])

    @vote = @post.votes.where(user_id: current_user.id).first
  end

  def c_vote_setup
    @post = Post.find(params[:post_id])
    @comment = @post.comments.find(params[:comment_id])

    @vote = @comment.votes.where(user_id: current_user.id).first
  end
end
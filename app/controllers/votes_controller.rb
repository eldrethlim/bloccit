# app/Controllers/votes_controller.rb

class VotesController < ApplicationController

before_action :load_vote_from_post, only: [:p_up_vote, :p_down_vote]
before_action :load_vote_from_comment, only: [:c_up_vote, :c_down_vote]

  def p_up_vote
    update_vote(1, {post: @post})

    redirect_to :back
  end

  def p_down_vote
    update_vote(-1, {post: @post})

    redirect_to :back
  end

  def c_up_vote
    update_vote(1, {comment: @comment})

    redirect_to :back
  end

  def c_down_vote
    update_vote(-1, {comment: @comment})

    redirect_to :back
  end

  private

  def update_vote(new_value, build_args)
    if @vote
      authorize @vote, :update?
      @vote.update_attribute(:value, new_value)
    else
      @vote = current_user.votes.build({value: new_value}.merge(build_args))
      authorize @vote, :create?
      @vote.save
    end
  end

  def load_post
    @post = Post.find(params[:post_id])
  end

  def load_comment
    load_post
    @comment = @post.comments.find(params[:comment_id])
  end

  def load_vote(parent)
    @vote = parent.votes.where(user_id: current_user.id).first
  end

  def load_vote_from_post
    load_post
    load_vote(@post)
  end

  def load_vote_from_comment
    load_comment
    load_vote(@comment)
  end

end
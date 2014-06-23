# app/policies/comment_policy.rb

class CommentPolicy < ApplicationPolicy
  def index?
    true
  end
end

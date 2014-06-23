# app/models/comment.rb 

class Comment < ActiveRecord::Base
  belongs_to :post
  belongs_to :user
  mount_uploader :image, CommentImageUploader

  default_scope { order('created_at DESC')}
  
  validates :body, presence: true
  validates :post, presence: true
  validates :user, presence: true
end
# app/models/user.rb

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable
  has_many :votes, dependent: :destroy
  has_many :posts
  has_many :comments
  has_many :favourites, dependent: :destroy
  mount_uploader :avatar, AvatarUploader
  #enum role: [:user, :moderator, :admin]
  #after_initialize :set_default_role, :if => :new_record?

  def self.top_rated
    self.select('users.*').
    select('COUNT(DISTINCT comments.id) AS comments_count').
    select('COUNT(DISTINCT posts.id) AS posts_count').
    select('COUNT(DISTINCT comments.id) + COUNT(DISTINCT posts.id) AS rank').
    joins(:posts).
    joins(:comments).
    group('users.id').
    order('rank DESC')
  end
  
  def set_default_role
    self.role ||= :user
  end

  def role?(base_role)
  	role == base_role.to_s
  end

  def favourited(post)
    self.favourites.where(post_id: post.id).first
  end

  def voted(votable)
    if votable.is_a?(Post)
      self.votes.where(post_id: votable.id).first
    else
      self.votes.where(comment_id: votable.id).first
    end
  end

end

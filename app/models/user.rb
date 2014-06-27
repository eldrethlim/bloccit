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

  def self.top_rated
    self.select('users.*').
    select('COUNT(DISTINCT comments.id) AS comments_count').
    select('COUNT(DISTINCT posts.id) AS posts_cound')
    select('COUNT(DISTINCT comments.id) + COUNT(DISTINCT posts.id) AS rank').
    joins(:posts).
    joins(:comments).
    group('users.id').
    order('rank DESC')
  end
  
  def role?(base_role)
  	role == base_role.to_s
  end

  def favourited(post)
    self.favourites.where(post_id: post.id).first
  end

  def voted(post)
    self.votes.where(post_id: post.id).first
  end
  
end

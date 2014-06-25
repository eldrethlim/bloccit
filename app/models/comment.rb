# app/models/comment.rb 

class Comment < ActiveRecord::Base
  belongs_to :post
  belongs_to :user
  has_many :votes, dependent: :destroy
  mount_uploader :image, CommentImageUploader

  default_scope { order('created_at DESC')}
  
  validates :body, presence: true
  validates :post, presence: true
  validates :user, presence: true

    def up_votes
    self.votes.where(value: 1).count
  end

  def down_votes
    self.votes.where(value: -1).count
  end

  def points
    self.votes.sum(:value).to_i
  end

  after_create :send_favourite_emails

  private

  def send_favourite_mails
    self.post.favourites.each do |favourite|
      FavouriteMailer.new_comment(favorite.user, self.post, self).deliver
    end
  end

  def create_vote
    user.votes.create(value: 1, comment: self)
  end
end
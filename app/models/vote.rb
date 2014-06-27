# app/models/vote.rb

class Vote < ActiveRecord::Base
  belongs_to :user
  belongs_to :post
  belongs_to :comment

  validates :value, inclusion: { in: [-1, 1], message: "%{value} is not a valid vote."}

  after_save :update_rank #post rank

  def up_vote?
    value == 1
  end

  def down_vote?
    value == -1
  end

  private

  def update_rank
    if self.post.present?
      self.post.update_rank
    end
  end
end
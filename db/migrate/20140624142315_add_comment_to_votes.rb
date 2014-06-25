class AddCommentToVotes < ActiveRecord::Migration
  def change
    add_reference :votes, :comment, index: true
  end
end

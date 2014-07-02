require 'rails_helper'

describe User do
  describe ".top_rated" do
    before :each do
      @user1 = create(:user)
      post = create(:post, user: @user1)
      create(:comment, user: @user1, post: post)

      @user2 = create(:user)
      post = create(:post, user: @user2)
      2.times { create(:comment, user: @user2, post: post) }
    end

    it "should return users based on comments + post" do
      expect( User.top_rated ).to eq([@user2, @user1])
    end

    it "should bump the first user to the top of the ranking when he makes 2 new comments" do
      2.times { create(:comment, user: @user1, post: @user1.posts.first) }
      expect( User.top_rated ).to eq([@user1, @user2])
    end

    it "should have 'post_count' on user" do
      users = User.top_rated
      expect( users.first.posts_count ).to eq(1)
    end

    it "should have 'comments_count' on user" do
      users = User.top_rated
      expect( users.first.comments_count ).to eq(2)
    end
  end

  describe "#role?" do

    it "should return true when passed an :admin for a user that's an admin" do
      @admin = create(:user, role: "admin")
      expect(@admin.role?(:admin)).to eq(true)
    end

    it "should return false when passed an :admin for user that's *not* an admin" do
      @user = create(:user, role: "moderator")
      expect(@user.role?(:admin)).to eq(false)
    end
  end
end
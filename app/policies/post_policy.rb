# app/policies/post_policy.rb

class PostPolicy < ApplicationPolicy
	def index?
		true
	end
end

# app/mailers/favourite_mailer.rb

class FavouriteMailer < ActionMailer::Base
  default from: "eldrethlim@gmail.com"

  def new_comment(user, post, comment)
    @user = user
    @post = post
    @comment = comment

    # New Headers
    headers["Message_ID"] = "<comments/#{@comment.id}@bloccitljx.heroku.com>"
    headers["In-Reply-To"] = "<post/#{@post.id}@bloccitljx.heroku.com>"
    headers["References"] = "<post/#{@post.id}@bloccitljx.heroku.com>"

    mail(to: user.email, subject: "New comment on #{post.title}")
  end
end
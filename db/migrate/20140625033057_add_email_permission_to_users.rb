class AddEmailPermissionToUsers < ActiveRecord::Migration
  def change
    add_column :users, :email_favourites, :boolean, default: false
  end
end

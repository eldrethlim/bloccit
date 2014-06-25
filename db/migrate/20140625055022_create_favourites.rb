class CreateFavourites < ActiveRecord::Migration
  def change
    create_table :favourites do |t|
      t.references :post, index: true
      t.references :user, index: true

      t.timestamps
    end
  end
end

class ChangefollowerIdLimit < ActiveRecord::Migration
  def change # anything inside this method is translated to SQL code and modifies the database (currently, SQLite)
    change_column :relationships, :follower_id, :integer, limit: 8 # add a new column to the table 'users' called 'username' of type 'string'
    change_column :relationships, :followed_id, :integer, limit: 8 # add a new column to the table 'users' called 'username' of type 'string'
  end
end

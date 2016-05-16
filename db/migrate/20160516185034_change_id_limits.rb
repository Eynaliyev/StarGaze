class ChangeIdLimits < ActiveRecord::Migration
  def change
  	change_column :categories, :user_id, :integer, limit: 8 # add a new column to the table 'users' called 'username' of type 'string'
    change_column :listings, :user_id, :integer, limit: 8 # add a new column to the table 'users' called 'username' of type 'string'
    change_column :users, :uid, :integer, limit: 8 # add a new column to the table 'users' called 'username' of type 'string'
    change_column :comments, :user_id, :integer, limit: 8 # add a new column to the table 'users' called 'username' of type 'string'
  end
end

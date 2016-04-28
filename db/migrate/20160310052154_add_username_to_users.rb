class AddUsernameToUsers < ActiveRecord::Migration
  def change #anything inside this method is translated to SQL code and modifies the database (currently, SQLite)
    add_column :users, :username, :string #add a new column to the table 'users' called 'username' of type 'string'
    add_index :users, :username, unique: true #first index usernames for quick (rapid) lookup. Second, ensure usernames are ALWAYS unique.
  end
end

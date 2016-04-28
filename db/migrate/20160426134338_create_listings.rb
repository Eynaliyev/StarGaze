class CreateListings < ActiveRecord::Migration
  def change
    create_table :listings do |t|
      t.text :name
      t.text :description
      t.references :user, index: true, foreign_key: true
      t.references :category

      t.timestamps null: false
    end
    add_index :listings, [:user_id, :created_at]
  end
end

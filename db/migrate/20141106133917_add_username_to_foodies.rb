class AddUsernameToFoodies < ActiveRecord::Migration
  def change
    add_column :foodies, :username, :string
    add_index :foodies, :username, unique: true
  end
end

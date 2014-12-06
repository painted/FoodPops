class AddFoodyIdToPhotos < ActiveRecord::Migration
  def change
    add_column :photos, :foody_id, :integer
  end
end

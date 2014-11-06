class AddFoodyIdToEvents < ActiveRecord::Migration
  def change
    add_reference :events, :foody, index: true
  end
end

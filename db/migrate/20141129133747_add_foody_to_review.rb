class AddFoodyToReview < ActiveRecord::Migration
  def change
    add_reference :reviews, :foody, index: true
  end
end

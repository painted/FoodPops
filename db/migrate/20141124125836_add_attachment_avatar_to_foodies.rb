class AddAttachmentAvatarToFoodies < ActiveRecord::Migration
  def self.up
    change_table :foodies do |t|
      t.attachment :avatar
    end
  end

  def self.down
    remove_attachment :foodies, :avatar
  end
end

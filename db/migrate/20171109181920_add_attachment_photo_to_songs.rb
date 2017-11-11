class AddAttachmentPhotoToSongs < ActiveRecord::Migration[5.1]
  def self.up
    change_table :songs do |t|
      t.attachment :photo
    end
  end

  def self.down
    remove_attachment :songs, :photo
  end
end

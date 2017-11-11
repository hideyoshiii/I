class AddAttachmentPhotoToBooks < ActiveRecord::Migration[5.1]
  def self.up
    change_table :books do |t|
      t.attachment :photo
    end
  end

  def self.down
    remove_attachment :books, :photo
  end
end

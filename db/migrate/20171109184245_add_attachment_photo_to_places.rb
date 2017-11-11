class AddAttachmentPhotoToPlaces < ActiveRecord::Migration[5.1]
  def self.up
    change_table :places do |t|
      t.attachment :photo
    end
  end

  def self.down
    remove_attachment :places, :photo
  end
end

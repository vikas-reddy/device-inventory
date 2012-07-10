class AddPhotoToDevice < ActiveRecord::Migration
  def up
    add_column :devices, :device_photo_file_name, :string
    add_column :devices, :device_photo_content_type, :string
    add_column :devices, :device_photo_file_size, :integer
  end
  
  def down
    remove_column :devices, :device_photo_file_name
    remove_column :devices, :device_photo_content_type
    remove_column :devices, :device_photo_file_size
  end
end

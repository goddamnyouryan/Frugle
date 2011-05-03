class AddBackgroundToNeighborhoods < ActiveRecord::Migration
  def self.up
    add_column :neighborhoods, :background_file_name,    :string
    add_column :neighborhoods, :background_content_type, :string
    add_column :neighborhoods, :background_file_size,    :integer
    add_column :neighborhoods, :background_updated_at,   :datetime
  end

  def self.down
  end
end

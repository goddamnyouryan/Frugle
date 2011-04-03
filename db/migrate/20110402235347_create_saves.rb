class CreateSaves < ActiveRecord::Migration
  def self.up
    create_table :saves do |t|
      t.integer :user_id
      t.integer :frugle_id

      t.timestamps
    end
  end

  def self.down
    drop_table :saves
  end
end

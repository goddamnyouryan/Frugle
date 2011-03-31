class CreateSubcategorizations < ActiveRecord::Migration
  def self.up
    create_table :subcategorizations do |t|
      t.integer :user_id
      t.integer :subcategory_id

      t.timestamps
    end
  end

  def self.down
    drop_table :subcategorizations
  end
end

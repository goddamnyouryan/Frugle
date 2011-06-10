class CreateAssignments < ActiveRecord::Migration
  def self.up
    create_table :assignments do |t|
      t.integer :user_id
      t.integer :zipcode_id
      t.string :zip

      t.timestamps
    end
  end

  def self.down
    drop_table :assignments
  end
end

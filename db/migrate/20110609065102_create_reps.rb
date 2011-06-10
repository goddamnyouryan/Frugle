class CreateReps < ActiveRecord::Migration
  def self.up
    create_table :reps do |t|
      t.string :name
      t.string :address
      t.string :zip
      t.string :phone
      t.integer :neighborhood_id
      t.string :subcategory_name

      t.timestamps
    end
  end

  def self.down
    drop_table :reps
  end
end

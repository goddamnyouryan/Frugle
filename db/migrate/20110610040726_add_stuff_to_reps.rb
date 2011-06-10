class AddStuffToReps < ActiveRecord::Migration
  def self.up
    add_column :reps, :status, :string, { :null => false, :default => "inactive" }
    add_column :reps, :notes, :text
    add_column :reps, :frugle, :string
    add_column :reps, :contact_name, :string
    add_column :reps, :contacted, :boolean, {:null => false, :default => false }
  end

  def self.down
    remove_column :reps, :contact_name
    remove_column :reps, :frugle
    remove_column :reps, :notes
    remove_column :reps, :status
  end
end

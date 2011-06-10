class AddEmailToRep < ActiveRecord::Migration
  def self.up
    add_column :reps, :email, :string
  end

  def self.down
    remove_column :reps, :email
  end
end

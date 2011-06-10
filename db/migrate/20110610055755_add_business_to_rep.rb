class AddBusinessToRep < ActiveRecord::Migration
  def self.up
    add_column :reps, :business_id, :integer
  end

  def self.down
    remove_column :reps, :business_id
  end
end

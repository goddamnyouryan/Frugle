class AddVerificationToBusiness < ActiveRecord::Migration
  def self.up
    add_column :businesses, :verification, :string
  end

  def self.down
    remove_column :businesses, :verification
  end
end

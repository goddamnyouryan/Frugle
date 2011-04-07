class AddPercentageAndProductToFrugles < ActiveRecord::Migration
  def self.up
    add_column :frugles, :percentage, :string
    add_column :frugles, :product, :string
  end

  def self.down
    remove_column :frugles, :product
    remove_column :frugles, :percentage
  end
end

class AddThingsToFrugles < ActiveRecord::Migration
  def self.up
    add_column :frugles, :other_offer, :boolean
    add_column :frugles, :visit, :boolean
    add_column :frugles, :altered, :boolean
    add_column :frugles, :customers, :string
  end

  def self.down
    remove_column :frugles, :customers
    remove_column :frugles, :altered
    remove_column :frugles, :visit
    remove_column :frugles, :other_offer
  end
end

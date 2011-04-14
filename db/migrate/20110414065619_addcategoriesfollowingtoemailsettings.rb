class Addcategoriesfollowingtoemailsettings < ActiveRecord::Migration
  def self.up
    add_column :email_settings, :categories_following, :boolean
  end

  def self.down
  end
end

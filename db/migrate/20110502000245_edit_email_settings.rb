class EditEmailSettings < ActiveRecord::Migration
  def self.up
    remove_column :email_settings, :new_frugles
    remove_column :email_settings, :interval
    change_column :email_settings, :businesses_following, :string
    change_column :email_settings, :categories_following, :string
    change_column :email_settings, :recommendations, :string
  end

  def self.down
  end
end

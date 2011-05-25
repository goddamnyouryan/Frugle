class AddIndexes < ActiveRecord::Migration
  def self.up
      add_index :user_tokens, :id
      add_index :saveds, :id
      add_index :follows, :id
      add_index :frugles, :id
      add_index :frugles, :verification
      add_index :neighborhoods, :id
      add_index :neighborhoods, :name
      add_index :businesses, :id
      add_index :users, :id
      add_index :email_settings, :id
      add_index :subcategories, :id
      add_index :categories, :id
      add_index :zipcodes, :id
      add_index :zipcodes, :zip
      add_index :subcategorizations, :id
      add_index :categorizations, :id
      add_index :saveds, :frugle_id
      add_index :saveds, :user_id
      add_index :user_tokens, :user_id
      add_index :follows, :user_id
      add_index :follows, :business_id
      add_index :frugles, :subcategory_id
      add_index :frugles, :business_id
      add_index :frugles, :category_id
      add_index :businesses, :neighborhood_id
      add_index :businesses, :user_id
      add_index :email_settings, :user_id
      add_index :subcategories, :category_id
      add_index :users, :neighborhood_id
      add_index :zipcodes, :neighborhood_id
      add_index :categorizations, :user_id
      add_index :categorizations, :category_id
      add_index :subcategorizations, :subcategory_id
      add_index :subcategorizations, :user_id
    end

    def self.down
      remove_index :user_tokens, :id
      remove_index :saveds, :id
      remove_index :follows, :id
      remove_index :frugles, :id
      remove_index :frugles, :verification
      remove_index :neighborhoods, :id
      remove_index :neighborhoods, :name
      remove_index :businesses, :id
      remove_index :users, :id
      remove_index :email_settings, :id
      remove_index :subcategories, :id
      remove_index :categories, :id
      remove_index :zipcodes, :id
      remove_index :zipcodes, :zip
      remove_index :subcategorizations, :id
      remove_index :categorizations, :id
      remove_index :saveds, :frugle_id
      remove_index :saveds, :user_id
      remove_index :user_tokens, :user_id
      remove_index :follows, :user_id
      remove_index :follows, :business_id
      remove_index :frugles, :subcategory_id
      remove_index :frugles, :business_id
      remove_index :frugles, :category_id
      remove_index :businesses, :neighborhood_id
      remove_index :businesses, :user_id
      remove_index :email_settings, :user_id
      remove_index :subcategories, :category_id
      remove_index :users, :neighborhood_id
      remove_index :zipcodes, :neighborhood_id
      remove_index :categorizations, :user_id
      remove_index :categorizations, :category_id
      remove_index :subcategorizations, :subcategory_id
      remove_index :subcategorizations, :user_id
    end

end

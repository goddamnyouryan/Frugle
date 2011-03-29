class CreateSubcategories < ActiveRecord::Migration
  def self.up
    create_table :subcategories do |t|
      t.integer :category_id
      t.string :title
      t.timestamps
    end
  end

  def self.down
    drop_table :subcategories
  end
end

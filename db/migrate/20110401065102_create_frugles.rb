class CreateFrugles < ActiveRecord::Migration
  def self.up
    create_table :frugles do |t|
      t.integer :business_id
      t.string :type
      t.text :details
      t.boolean :mobile
      t.integer :quantity
      t.integer :views
      t.datetime :start
      t.datetime :end
      t.string :verification
      t.string :status
      t.timestamps
    end
  end

  def self.down
    drop_table :frugles
  end
end

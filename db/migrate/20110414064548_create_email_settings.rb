class CreateEmailSettings < ActiveRecord::Migration
  def self.up
    create_table :email_settings do |t|
      t.boolean :newsletter
      t.boolean :new_frugles
      t.string :interval
      t.boolean :businesses_following
      t.boolean :recommendations
      t.integer :user_id

      t.timestamps
    end
  end

  def self.down
    drop_table :email_settings
  end
end

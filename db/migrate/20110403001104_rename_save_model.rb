class RenameSaveModel < ActiveRecord::Migration
  def self.up
    rename_table(:saves, :saveds)
  end

  def self.down
  end
end

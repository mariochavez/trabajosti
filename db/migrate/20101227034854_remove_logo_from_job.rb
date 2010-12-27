class RemoveLogoFromJob < ActiveRecord::Migration
  def self.up
    remove_column :jobs, :logo
  end

  def self.down
    add_column :jobs, :logo, :string
  end
end

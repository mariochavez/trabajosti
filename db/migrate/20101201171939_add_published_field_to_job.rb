class AddPublishedFieldToJob < ActiveRecord::Migration
  def self.up
    add_column :jobs, :published, :boolean
    remove_column :jobs, :edit_token
  end

  def self.down
    remove_column :jobs, :published
    add_column :jobs, :edit_token, :string
  end
end

class AddEditTokenToJob < ActiveRecord::Migration
  def self.up
    add_column :jobs, :edit_token, :string
  end

  def self.down
    remove_column :jobs, :edit_token
  end
end

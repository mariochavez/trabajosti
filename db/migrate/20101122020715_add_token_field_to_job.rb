class AddTokenFieldToJob < ActiveRecord::Migration
  def self.up
    add_column :jobs, :token, :string
  end

  def self.down
    remove_column :jobs, :token
  end
end

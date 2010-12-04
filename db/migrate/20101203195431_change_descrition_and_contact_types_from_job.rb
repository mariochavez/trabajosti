class ChangeDescritionAndContactTypesFromJob < ActiveRecord::Migration
  def self.up
    change_column :jobs, :description, :text
    change_column :jobs, :contact, :text
  end

  def self.down
    change_column :jobs, :description, :string
    change_column :jobs, :contact, :string
  end
end

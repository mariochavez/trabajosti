# rake environment RAILS_ENV=test db:migrate
#
class CreateJobs < ActiveRecord::Migration
  def self.up
    create_table :jobs do |t|
      t.string :title
      t.integer :category
      t.string :location
      t.text :description
      t.text :contact
      t.string :company_name
      t.string :logo
      t.string :url
      t.string :email

      t.timestamps
    end
  end

  def self.down
    drop_table :jobs
  end
end

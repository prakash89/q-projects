class CreateProjects < ActiveRecord::Migration
  def self.up
    create_table :projects do |t|
      t.string :name
      t.text :description
      t.string :pretty_url
      t.references :client, index: true
      t.timestamps
    end
  end

  def self.down
    drop_table :projects
  end
end
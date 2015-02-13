class CreateProjects < ActiveRecord::Migration
  def self.up
    create_table :projects do |t|
      t.string :name, limit: 256
      t.string :description, limit: 2056
      t.string :pretty_url, limit: 512
      t.references :client, index: true
      t.timestamps
    end
  end

  def self.down
    drop_table :projects
  end
end
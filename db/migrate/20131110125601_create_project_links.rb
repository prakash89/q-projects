class CreateProjectLinks < ActiveRecord::Migration
  def self.up
    create_table :project_links do |t|

      t.references :link_type, index: true
      t.references :project, index: true
      t.text :url
      t.boolean :under_construction

      t.timestamps

    end
  end

  def self.down
    drop_table :project_links
  end
end
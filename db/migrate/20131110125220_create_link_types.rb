class CreateLinkTypes < ActiveRecord::Migration
  def self.up
    create_table :link_types do |t|
      t.string :name
      t.string :description, limit: 2056
      t.string :button_text, limit: 56
      t.timestamps
    end
  end

  def self.down
    drop_table :link_types
  end
end
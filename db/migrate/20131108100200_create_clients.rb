class CreateClients < ActiveRecord::Migration
  def self.up
    create_table :clients do |t|
      t.string :name
      t.string :description, limit: 2056
      t.string :city
      t.string :state
      t.string :country
      t.string :pretty_url, limit: 512
      t.timestamps
    end
  end

  def self.down
    drop_table :clients
  end
end
class CreateClients < ActiveRecord::Migration
  def self.up
    create_table :clients do |t|
      t.string :name, limit: 256
      t.string :description, limit: 2056
      t.string :city, limit: 256
      t.string :state, limit: 256
      t.string :country, limit: 256
      t.string :pretty_url, limit: 512
      t.timestamps
    end
  end

  def self.down
    drop_table :clients
  end
end
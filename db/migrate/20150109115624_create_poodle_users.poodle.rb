# This migration comes from poodle (originally 20131108102729)
# This is a migration file copied from Poodle.
# Do not change this file if you are not good at configuring Poodle.
class CreatePoodleUsers < ActiveRecord::Migration
  def change
    create_table(:users) do |t|

      t.string :name, limit: 256
      t.string :username, :null => false, :limit=>32
      t.string :email, :null => false, limit: 256

      t.text :biography

      t.string :phone, :null => true, :limit=>16
      t.string :skype, :null => true, :limit=>128
      t.string :linkedin, :null => true, :limit=>128

      t.string :city, :null => true, :limit=>128
      t.string :state, :null => true, :limit=>128
      t.string :country, :null => true, :limit=>128

      t.string :department, :null => true, :limit=>128
      t.string :designation, :null => true, :limit=>128

      t.string :thumb_url, :null => true, :limit=>512
      t.string :medium_url, :null => true, :limit=>512
      t.string :large_url, :null => true, :limit=>512
      t.string :original_url, :null => true, :limit=>512

      t.string :user_type, :null => false
      t.integer :q_auth_uid, :null => false

      t.string :auth_token, :null => false, limit: 512
      t.datetime :token_created_at, :null => false


      t.references :client

      t.timestamps
    end

    add_index :users, :email,                :unique => true
    add_index :users, :username,             :unique => true
    add_index :users, :q_auth_uid,           :unique => true
    add_index :users, :auth_token,           :unique => true
  end
end

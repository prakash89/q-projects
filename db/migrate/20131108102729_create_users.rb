class CreateUsers < ActiveRecord::Migration
  def change
    create_table(:users) do |t|

      ## First Name, Last Name and Username
      t.string :name, limit: 255
      t.string :username, :null => false, :limit=>32
      t.string :email, :null => false

      t.text :biography

      t.string :phone, :null => true, :limit=>16
      t.string :status, :null => false, :default=>"pending", :limit=>16

      t.string :skype, :null => true, :limit=>128
      t.string :linkedin, :null => true, :limit=>128

      t.string :city, :null => true, :limit=>128
      t.string :state, :null => true, :limit=>128
      t.string :country, :null => true, :limit=>128

      t.string :department, :null => true, :limit=>128
      t.string :designation, :null => true, :limit=>128
      t.string :designation_overridden, :null => true, :limit=>56

      t.string :profile_picture_url, :null => true, :limit=>512

      ## Token authenticatable
      t.integer :q_auth_uid
      t.string :auth_token
      t.string :user_type

      t.references :client

      t.timestamps
    end

    add_index :users, :email,                :unique => true
    add_index :users, :auth_token,           :unique => true

  end
end

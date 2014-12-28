class AddTokenExpiresAtToUsers < ActiveRecord::Migration
  def change
    add_column :users, :token_expires_at, :datetime, default: nil
  end
end

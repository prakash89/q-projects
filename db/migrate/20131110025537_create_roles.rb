class CreateRoles < ActiveRecord::Migration
  def change
    create_table(:roles) do |t|
      t.string :name
      t.references :project
      t.references :user
      t.timestamps
    end

    add_index(:roles, :name)
    add_index(:roles, [ :project_id, :user_id])
  end
end

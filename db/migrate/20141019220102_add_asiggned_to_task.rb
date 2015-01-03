class AddAsiggnedToTask < ActiveRecord::Migration
  def change
    add_column :tasks, :assigned_to_id, :integer
  end
end

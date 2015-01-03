class AddStateToTasks < ActiveRecord::Migration
  def change
  	remove_column :tasks, :status, :integer
    add_column :tasks, :state_id, :integer
  end
end

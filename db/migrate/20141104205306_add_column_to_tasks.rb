class AddColumnToTasks < ActiveRecord::Migration
  def change
    add_column :tasks, :real_deadline, :datetime
  end
end

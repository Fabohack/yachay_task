class AddDateColumnsToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :estimated_start_date, :datetime
    add_column :projects, :estimated_end_date, :datetime
    add_column :projects, :real_start_date, :datetime
    add_column :projects, :real_end_date, :datetime
  end
end

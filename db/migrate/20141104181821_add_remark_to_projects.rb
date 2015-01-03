class AddRemarkToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :remark, :text
  end
end

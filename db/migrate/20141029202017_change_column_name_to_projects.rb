class ChangeColumnNameToProjects < ActiveRecord::Migration
  def change
    change_column :projects,:name,:text
  end
end

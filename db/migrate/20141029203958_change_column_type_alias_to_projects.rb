class ChangeColumnTypeAliasToProjects < ActiveRecord::Migration
  def change
    change_column :projects,:alias,:text
  end
end

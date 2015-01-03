class AddIsCriticToProject < ActiveRecord::Migration
  def change

  	#remove_column :projects, :is_critic,  :boolean, default: false
    add_column :projects, :is_critical,  :boolean, default: false
  end
end

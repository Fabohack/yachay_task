class RemoveEstimatedBudgetFromProjects < ActiveRecord::Migration
  def change
    remove_column :projects, :estimated_budget, :string
    add_column :projects, :price_cents, :integer, :limit => 8, default: 0
    add_column :projects, :alias, :string
  end
end

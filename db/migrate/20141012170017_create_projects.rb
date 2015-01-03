class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :name
      t.text :description
      t.decimal :estimated_budget, default: 0, null: false
      t.boolean :is_strategic, default: false, null: false
      t.integer :status, default: 0, null: false

      t.timestamps
    end
  end
end

class CreateGoals < ActiveRecord::Migration
  def change
    create_table :goals do |t|
      t.string :name
      t.references :organization, index: true

      t.timestamps
    end
    add_index :goals, [:organization_id, :created_at]
  end
end

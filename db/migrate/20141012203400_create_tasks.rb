class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.text :description
      t.datetime :deadline
      t.integer :complexity, default: 0, null: false
      t.integer :score, default: 0, null: false
      t.integer :status, default: 0, null: false
      t.references :project, index: true

      t.timestamps
    end
  end
end

class CreateAlignments < ActiveRecord::Migration
  def change
    create_table :alignments do |t|
      t.references :project, index: true
      t.references :goal, index: true

      t.timestamps
    end
  end
end

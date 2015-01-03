class CreateInpairments < ActiveRecord::Migration
  def change
    create_table :inpairments do |t|
      t.text :description
      t.timestamps
    end
  end
end

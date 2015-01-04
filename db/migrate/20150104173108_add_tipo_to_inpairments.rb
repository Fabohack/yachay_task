class AddTipoToInpairments < ActiveRecord::Migration
  def change
    add_column :inpairments, :tipo, :integer
  end
end

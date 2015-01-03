class AddUserTaskRefToInpairments < ActiveRecord::Migration
  def change
    add_reference :inpairments, :user, index: true
    add_reference :inpairments, :task, index: true
  end
end

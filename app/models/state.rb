class State < ActiveRecord::Base
  has_many :tasks
  #belongs_to :task
  validates :name, :presence => true

end

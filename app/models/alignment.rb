class Alignment < ActiveRecord::Base
  belongs_to :project
  belongs_to :goal
end

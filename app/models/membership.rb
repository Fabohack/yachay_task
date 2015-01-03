class Membership < ActiveRecord::Base
  belongs_to :project
  belongs_to :user

  RESPONSIBLE_ROLE_OPTIONS = ['Principal','Backup', 'Helper']
  
  validates :responsible_role, inclusion: { in: RESPONSIBLE_ROLE_OPTIONS }

end

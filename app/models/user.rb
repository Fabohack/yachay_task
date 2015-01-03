class User < ActiveRecord::Base
  has_many :memberships, dependent: :destroy
  has_many :projects, through: :memberships

  has_many :inpairments, :dependent => :destroy

  #has_many :tasks, dependent: :destroy

  enum role: [:user, :admin, :vip]

  #rol     0     1     2
  #after_initialize :set_default_role, :if => :new_record?
  after_create :check_if_admin_needs_to_be_made

  def check_if_admin_needs_to_be_made
    if User.all.size == 1  #Si no hay usuarios => el primer usuario que sign up lo asigna como admin
      self.role = :admin
    else
      self.role = :user    # si ya existe usuarios => le asignará role user de forma predeterminada
    end
    self.save
  end

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end

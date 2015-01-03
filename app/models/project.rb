class Project < ActiveRecord::Base
	
	has_many :tasks, dependent: :destroy
	has_many :memberships, dependent: :destroy
	has_many :users, through: :memberships

	enum status: [:open, :closed, :suspended, :transferred]
	
	has_many :alignments, dependent: :destroy
	has_many :goals, through: :alignments
	
	validates :name, presence: true

	validates :alias, presence: true
  #valida que ingrese hasta 255 caracteres y permite ingresar de igual forma el campo en blanco
  validates :description, length: { in: 0..2000 },allow_blank: true

  validates :name, length: { in: 0..500 }

  validates :name, length: { in: 0..1000 }

  validates :goal_ids, :presence => {:message => "Goal one is necessary"}

  validates :remark, length: { in: 0..2000 },allow_blank: true

  #validaciones para el campo presupuesto 
  monetize :price_cents, :allow_nil => false, :numericality => { :greater_than_or_equal_to => 0 }

	def estimated?
		price.blank? || price.zero?
	end

end

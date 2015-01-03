class Goal < ActiveRecord::Base
  belongs_to :organization
  has_many :alignments, dependent: :destroy
  has_many :projects, through: :alignments

  validates :name, presence: true, uniqueness: true, length: { maximum: 250 }
end

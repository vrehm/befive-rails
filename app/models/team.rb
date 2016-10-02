class Team < ApplicationRecord

  has_attachment :photo

  belongs_to :user
  has_many :members, dependent: :destroy

  validates :name, presence: true
  validates :city, presence: true
end

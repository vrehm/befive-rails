class Event < ApplicationRecord
  belongs_to :user
  belongs_to :team
  belongs_to :location

  has_many :activities, dependent: :destroy
  has_many :participations, dependent: :destroy
  has_many :comments, dependent: :destroy

  validates :category, presence: true
  validates :date, presence: true
  validates :time, presence: true
  validates :location_id, presence: true
  validates :address, presence: true
end

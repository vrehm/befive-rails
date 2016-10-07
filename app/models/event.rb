class Event < ApplicationRecord
  belongs_to :user
  belongs_to :team
  belongs_to :location

  validates :category, presence: true
  validates :datetime, presence: true
  validates :location_id, presence: true
  validates :address, presence: true
end
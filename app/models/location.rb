class Location < ApplicationRecord
  has_many :teams
  has_many :events
end

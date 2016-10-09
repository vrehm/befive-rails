class Activity < ApplicationRecord
  belongs_to :user
  belongs_to :team
  belongs_to :event, optional: true
  belongs_to :member, optional: true
end

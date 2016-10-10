class Team < ApplicationRecord

  include PgSearch
  pg_search_scope :global_search,
    against: [ :name, :city ],
    associated_against: {
      location: [ :name ],
      user: [ :first_name, :last_name ]
    }

  has_attachment :photo

  belongs_to :user
  has_many :members, dependent: :destroy
  has_many :invitations, dependent: :destroy
  has_many :relationships, dependent: :destroy
  has_many :events, dependent: :destroy
  has_many :activities, dependent: :destroy
  has_many :participations, dependent: :destroy

  belongs_to :logo
  belongs_to :location

  validates :name, presence: true
  validates :city, presence: true
end

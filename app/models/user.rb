class User < ApplicationRecord

  has_attachment :avatar

  has_many :teams, :through => :members
  has_many :teams, dependent: :destroy
  has_many :members, dependent: :destroy
  has_many :invitations, dependent: :destroy

  validates :first_name, presence: true
  validates :last_name, presence: true
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  after_create :send_welcome_email

  private

  def send_welcome_email
    UserMailer.welcome(self).deliver_now
  end

end

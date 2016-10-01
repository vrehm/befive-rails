class User < ApplicationRecord

  has_attachment :avatar

  has_many :teams
  has_many :teams, :through => :members
  has_many :members
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end

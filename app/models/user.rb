class User < ApplicationRecord
  has_secure_password
  has_one_attached :image
  has_many :rooms
  has_many :books

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[\w+\-.]+\z/i

  validates :name, presence: true
  validates :introduction, presence: true, on: :update
  validates :email, presence: true, uniqueness: true, format: {with: VALID_EMAIL_REGEX}

end

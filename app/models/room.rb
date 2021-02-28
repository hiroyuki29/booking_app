class Room < ApplicationRecord
  has_one_attached :image
  belongs_to :user
  has_many :books

  validate :image_presence
  validates :name, presence: true
  validates :introduction, presence: true
  validates :price, presence: true, numericality: true
  validates :address, presence: true


  def image_presence
    if !image.attached?
      errors.add(:image, "ファイルを添付してください")
    end
  end
end

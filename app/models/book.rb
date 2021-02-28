class Book < ApplicationRecord
  belongs_to :user
  belongs_to :room

  validates :start_day, presence: true
  validates :end_day, presence: true
  validates :person_number, presence: true, numericality: true

  validates_acceptance_of :confirming, allow_nil: false
  after_validation :check_confirming

  validate :start_before_today

  def check_confirming
    errors.delete(:confirming)
    self.confirming = errors.empty? ? '1' : ''
  end

  def start_before_today
    if !start_day.blank?
      errors.add(:start_day,  "は今日以降を選択してください") if start_day < Date.today
    end
  end
end

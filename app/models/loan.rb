class Loan < ApplicationRecord

  validate :different_uid

  validates :amount, presence: true,
            numericality: {
                only_integer: true,
                greater_than_or_equal_to: 0
            }

  belongs_to :from, class_name: 'User'
  belongs_to :to, class_name: 'User'

  def different_uid
    errors.add(:to_id, "Can't be same as from user") if from_id == to_id
  end

end

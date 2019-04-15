class Period < ApplicationRecord
  belongs_to :user
  has_many :period_items
  has_many :items, through: :period_items

  scope :active, -> { where(is_active: true) }
end

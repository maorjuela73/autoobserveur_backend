class Item < ApplicationRecord
  has_many :period_items
  has_many :periods, through: :period_items
  has_many :advices
end

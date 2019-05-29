class PeriodItem < ApplicationRecord
  belongs_to :period
  belongs_to :item
  has_many :marks
end

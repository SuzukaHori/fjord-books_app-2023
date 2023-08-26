class Mention < ApplicationRecord
  belongs_to :mentioning, class_name: 'Report'
  belongs_to :mentioned, class_name: 'Report'
  validates :mentioning_id, presence: true
  validates :mentioned, presence: true
end

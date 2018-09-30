class House < ApplicationRecord
  validates :realtor_id, presence: true
  belongs_to :realtor
end

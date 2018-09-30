class User < ApplicationRecord
  validates :email_id, presence: true, uniqueness: true
end

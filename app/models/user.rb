class User < ApplicationRecord
  validates :email_id, presence: true, uniqueness: true
  validates :password, presence: true

  def self.find_or_create_from_auth_hash(auth)
    where(provider: auth.provider, auth_uid: auth.uid).first_or_initialize.tap do |user|
      user.provider = auth.provider
      user.auth_uid = auth.uid
      user.email_id = auth.info.email
      user.is_realtor = true
      user.password = "."
      user.save!
      realtor = Realtor.new
      realtor.users_id = user.id
      realtor.first_name = auth.info.first_name
      realtor.last_name = auth.info.last_name
      realtor.save!
    end
  end
end

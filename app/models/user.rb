class User < ApplicationRecord
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  has_secure_password

  before_save :create_api_key

  def create_api_key
    self.api_key = SecureRandom.uuid
  end
end

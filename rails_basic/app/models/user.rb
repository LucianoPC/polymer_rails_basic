require 'securerandom'

class User < ApplicationRecord

  before_create :set_auth_token

  has_secure_password

  validates :password, presence: false, length: { minimum: 6 }, allow_nil: true
  validates :password_confirmation, presence: false, allow_nil: true

  validates_presence_of :name, :email
  validates_uniqueness_of :email

  private

  def set_auth_token
    return if auth_token.present?
    self.auth_token = generate_auth_token
  end

  def generate_auth_token
    SecureRandom.uuid.gsub(/\-/,'')
  end
end

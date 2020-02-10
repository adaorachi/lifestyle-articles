class User < ApplicationRecord
  attr_accessor :remember_token

  has_many :articles, foreign_key: 'author_id', dependent: :destroy


  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i.freeze
  validates :name, presence: true, length: { in: 3..50 }
  validates :username, presence: true, length: { in: 3..50 },
                       uniqueness: { case_sensitive: false }
  validates :email, presence: true, length: { maximum: 255 },
                    uniqueness: { case_sensitive: false },
                    format: { with: VALID_EMAIL_REGEX }
  validates :password, presence: true, length: { maximum: 255 }

  has_secure_password

  def self.hash_string(string)
    Digest::SHA1.hexdigest(string)
  end

  def self.new_token
    SecureRandom.urlsafe_base64
  end

  def create_token_db
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.hash_string(remember_token))
  end

  def authenticate?(remember_token)
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  def forget_digest_db
    update_attribute(:remember_digest, nil)
  end
  private

  def downcase_email_username
    self.email = email.downcase
    self.username = username.downcase
  end
end

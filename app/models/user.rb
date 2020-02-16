class User < ApplicationRecord
  before_save :downcase_email_username

  attr_accessor :remember_token

  has_many :articles, foreign_key: 'author_id', dependent: :destroy

  has_many :votes, foreign_key: 'user_id', dependent: :destroy
  has_many :voted_articles, through: :votes, source: :article

  has_many :bookmarks, foreign_key: 'user_id', dependent: :destroy
  has_many :bookmarked_articles, through: :bookmarks, source: :article

  mount_uploader :avatar, AvatarUploader

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

  def vote(article)
    voted_articles << article
  end

  def unvote(article)
    voted_articles.delete(article)
  end

  def voted?(article)
    voted_articles.include?(article)
  end

  def bookmark(article)
    bookmarked_articles << article
  end

  def unbookmark(article)
    bookmarked_articles.delete(article)
  end

  def bookmarked?(article)
    bookmarked_articles.include?(article)
  end

  private

  def downcase_email_username
    self.email = email.downcase
    self.username = username.downcase
  end

  def save_avatar
    avatar = gravatar_for(self.email)
    self.update_column(:avatar, avatar)
  end

  def gravatar_for(email, size: 80)
    gravatar_id = Digest::MD5::hexdigest(email.downcase)
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
    gravatar_url
  end

end

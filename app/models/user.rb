class User < ApplicationRecord
  has_many :microposts, dependent: :destroy
  has_many :active_relationships , class_name: 'Relationship', foreign_key: 'follower_id', dependent: :destroy
  has_many :passive_relationships, class_name: 'Relationship', foreign_key: 'followed_id', dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower
  before_save :downcase_email
  before_create :create_activation_digest
  has_secure_password
  attr_accessor :remember_token, :activation_token

  validates :name, presence: true, length: { maximum: 50 }
  validates :email,
    presence: true,
    length: { maximum: 255 },
    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
    uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: 6 }, allow_blank: true

  # Returns the hash digest of the given string.
  def self.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  def self.new_token
    SecureRandom.urlsafe_base64
  end

  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  def forget
    update_attribute(:remember_digest, nil)
  end

  # Returns true if the given token matches the digest.
  # Used to authenticate both activation and remember tokens
  def authenticated?(attr, token)
    digest = send("#{attr}_digest")
    return false if remember_digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end

  def feed
    Micropost.where('user_id = ?', id)
  end

  def follow(new_user)
    following << new_user 
  end

  def unfollow(other_user)
    following.delete(other_user)
  end

  def following?(other_user)
    following.include?(other_user)
  end

  private

  def create_activation_digest
    self.activation_token = User.new_token
    self.activation_digest = User.digest(activation_token)
  end

  def downcase_email
    self.email = email.downcase
  end
end

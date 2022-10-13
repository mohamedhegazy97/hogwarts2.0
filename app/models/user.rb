class User < ApplicationRecord
  validates_presence_of :name,:email,:password,:birth_date,:hogwarts_house
  enum  hogwarts_house: { Gryffindor: 'Gryffindor', Hufflepuff: 'Hufflepuff', Slytherin: 'Slytherin' , Ravenclaw: 'Ravenclaw'}
  has_one_attached :image
  has_many :spells, dependent: :destroy
  has_many :active_relationships, class_name: "Relationship",foreign_key: "follower_id",dependent: :destroy
  has_many :passive_relationships, class_name: "Relationship",foreign_key: "followed_id",dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower
  attr_accessor :remember_token , :reset_token
  before_save { self.email = email.downcase }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, format:{ with: VALID_EMAIL_REGEX},uniqueness: true
  VALID_PASSWORD_REGEX = /(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])/ 
  has_secure_password 
  validates :password, format:{ with: VALID_PASSWORD_REGEX}, allow_nil: true,unless: :skip_password_validation  
  validates :image,content_type: { in: %w[image/jpeg image/gif image/png image/svg],message: "must be a valid image format" }
  attr_accessor :skip_password_validation
class << self
  # Returns the hash digest of the given string.
  def digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
    BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end


  # Returns a random token.
  def new_token
    SecureRandom.urlsafe_base64
  end
end

  # Remembers a user in the database for use in persistent sessions.
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  # Returns true if the given token matches the digest.
  def authenticated?(attribute, token)
    digest = send("#{attribute}_digest")
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end

  # Forgets a user.
  def forget
    update_attribute(:remember_digest, nil)
  end

  # Sets the password reset attributes.
  def create_reset_digest
    self.reset_token = User.new_token
    update_attribute(:reset_digest, User.digest(reset_token))
    update_attribute(:reset_sent_at, Time.zone.now)
  end
  
  # Sends password reset email.
  def send_password_reset_email
    UserMailer.password_reset(self).deliver_now
  end

  # Returns true if a password reset has expired.
  def password_reset_expired?
    reset_sent_at < 2.hours.ago
  end

  # Follows a user.
  def follow(other_user)
    following << other_user unless self == other_user
  end
  
  # Unfollows a user.
  def unfollow(other_user)
    following.delete(other_user)
  end
  
  # Returns true if the current user is following the other user.
  def following?(other_user)
    following.include?(other_user)
  end

  # Returns a resized image for display.
  def display_image
    image.variant(resize_to_limit: [500, 500])
  end
end
class Member < ActiveRecord::Base
  attr_accessor :remember_token, :activation_token, :reset_token, :gender
  before_create :create_activation_digest

  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }, allow_blank: true

  validates :first_name, presence: true, allow_blank: false
  validates :email, presence: true, uniqueness: true, allow_blank: false

  # Returns a random token.
  def Member.new_token
    SecureRandom.urlsafe_base64
  end

  # Remembers a user in the database for use in persistent sessions.
  def remember
    self.remember_token = Member.new_token
    update_attribute(:remember_digest, Member.digest(remember_token))
  end

  # Forgets a user.
  def forget
    update_attribute(:remember_digest, nil)
  end

  # Returns the hash digest of the given string.
  def Member.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  # Returns true if the given token matches the digest.
  def authenticated?(attribute, token)
    digest = send("#{attribute}_digest")
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end

  # Activates an account.
  def activate
    update_attribute(:is_active, true)
    update_attribute(:activated_at, Time.zone.now)
  end

  # Sends activation email.
  def send_activation_email
    UserMailer.account_activation(self).deliver_later
  end

  # Sets the password reset attributes.
  def create_reset_digest
    self.reset_token = Member.new_token
    update_attribute(:reset_digest, Member.digest(reset_token))
    update_attribute(:reset_sent_at, Time.zone.now)
  end

  # Sends password reset email.
  def send_password_reset_email
    UserMailer.password_reset(self).deliver_later
  end

  # Returns true if a password reset has expired.
  def password_reset_expired?
    reset_sent_at < 2.hours.ago
  end

  private
  def create_activation_digest
    self.activation_token = Member.new_token
    self.activation_digest = Member.digest(activation_token)
  end
end

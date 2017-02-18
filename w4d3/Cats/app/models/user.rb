class User < ActiveRecord::Base

  validates :user_name, presence: true
  # validates :password_digest, presence: true
  # validates :password, length: {minimum: 6, allow_nil: true}
  validates :session_token, presence: true, uniqueness: true

  after_initialize :ensure_session_token

  has_many :cats,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: :Cat

  has_many :cat_rental_requests,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: :CatRentalRequest

  attr_reader :password

  def self.find_by_credentials(user_name, password)
    user = User.find_by(user_name: user_name)
    return user if user && user.is_password?(password)
    nil
  end

  def reset_token!
    # fail
    self.session_token = SecureRandom::urlsafe_base64(16)
    self.save!
    self.session_token
  end

  def password=(password)
    # fail
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def is_password?(password)
    # fail
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end

  def ensure_session_token
    # fail
    self.session_token ||= SecureRandom::urlsafe_base64(16)
  end


end

class User < ActiveRecord::Base
  attr_reader :password

  has_many :posts, foreign_key: :author_id
  has_many :subs, foreign_key: :moderator_id
  has_many :comments, foreign_key: :author_id, inverse_of: :author

  validates :username, :password_digest, :session_token, presence: true
  validates :password, length: {minimum: 6, allow_nil: true}
  after_initialize :ensure_session_token

  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password).to_s
  end

  def ensure_session_token
    self.session_token ||=  SecureRandom.base64(16)
  end

  def reset_session_token!
    self.session_token = SecureRandom.base64(16)
    self.save!
    self.session_token
  end

  def self.find_by_credentials(username, password)
    @user = User.find_by_username(username)
    @user && @user.is_password?(password) ? @user : nil
  end

end

require 'bcrypt'

class User < ActiveRecord::Base
  include BCrypt

  validates :name, presence:    true,
                   uniqueness:  true

  # using gem email_validator
  validates :email, presence:     true,
                    uniqueness:   true,
                    confirmation: true,
                    email:        true

  validates :password, presence:     true,
                       length:       { minimum: 5 },
                       confirmation: true

  before_save { self.email = email.downcase }

  before_save :encrypt_password, if: :password_changed?

  def encrypt_password
    self.salt = BCrypt::Engine.generate_salt
    self.password = BCrypt::Engine.hash_secret password, salt
  end

  # Exclude password, salt and encrypted_password info from json output.
  def as_json(options)
    options[:except] ||= [:password, :salt]
    super(options)
  end

end

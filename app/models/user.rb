require 'bcrypt'

class User < ActiveRecord::Base
  include BCrypt

  validates :name, :presence    => true,
                   :uniqueness  => true

  # using gem email_validator
  validates :email, :presence     => true,
                    :uniqueness   => true,
                    :confirmation => true,
                    :email        => true

  validates :password, :presence     => true,
                       :length       => { :minimum => 5 },
                       :confirmation => true

  before_save { self.email = email.downcase }

  before_save :encrypt_password
  def encrypt_password
    if password.present?
      self.salt = BCrypt::Engine.generate_salt
      self.encrypted_password = BCrypt::Engine.hash_secret(password, salt)
      self.password = nil
    end
  end

  # Exclude password, salt and encrypted_password info from json output.
  def as_json(options)
    options[:except] ||= [:password, :salt, :encrypted_password]
    super(options)
  end

end

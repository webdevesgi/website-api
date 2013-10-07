class User < ActiveRecord::Base
  validates :name, :presence    => true,
                   :uniqueness  => true

  # using gem validates_email_format_of
  validates :email, :presence     => true,
                    :uniqueness   => true,
                    :confirmation => true#,
                    #:email        => true
  # FIXME gem email validator
  #validates :email, :email => true

  validates :password, :presence     => true,
                       :length       => { :minimum => 5 },
                       :confirmation => true
end

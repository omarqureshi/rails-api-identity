class User < ActiveRecord::Base
  attr_accessible :email, :password, :password_confirmation
  has_secure_password

  after_validation :set_token, :on => :create

  def set_token
    self.token = SecureRandom.uuid
  end
end

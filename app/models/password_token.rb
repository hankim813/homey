class PasswordToken < ActiveRecord::Base
  validates_presence_of :passkey
end
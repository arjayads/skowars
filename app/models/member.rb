class Member < ActiveRecord::Base
  has_secure_password
  validates :password, presence: true, confirmation: true, length: { minimum: 6 }
end

class Member < ActiveRecord::Base
  has_secure_password
  validates :password, presence: true, confirmation: true, length: { minimum: 6 }, allow_blank: true
  validates :first_name, presence: true, allow_blank: false
  validates :gender, presence: { message: 'must either Male or Female' }
  validates :email, presence: true, uniqueness: true, allow_blank: false
end

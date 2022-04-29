class Student < ApplicationRecord
  has_secure_password
  validates_uniqueness_of :uin
end

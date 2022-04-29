class Student < ApplicationRecord
  validates_uniqueness_of :uin
end

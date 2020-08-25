class User < ApplicationRecord
  validates_uniqueness_of :username
  validates :username, presence: true, length: { minimum: 3, maximum: 25 }
end

class Administrator < ActiveRecord::Base
  attr_accessible :username

  validates :username, uniqueness: true, format: /^[a-z]+$/, presence: true
end

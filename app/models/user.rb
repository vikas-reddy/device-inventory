class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :owned_devices, foreign_key: :owner_id, class_name: 'Device'
  has_many :possessed_devices, foreign_key: :possesser_id, class_name: 'Device'

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :name

  validates :email, uniqueness: true, presence: true
end

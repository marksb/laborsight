class User < ActiveRecord::Base

  validates_presence_of :first_name, :last_name, :username, :email, :password_digest, :default_city, :default_state
  validates_uniqueness_of :username, :email
  validates_length_of :default_state, :is => 2

  attr_accessible :first_name, :last_name, :username, :email, :password_digest, :default_city, :default_state

  has_secure_password
end

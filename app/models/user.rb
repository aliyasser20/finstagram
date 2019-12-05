class User < ActiveRecord::Base

  has_many :finstagram_post
  has_many :comment
  has_many :like

  validates :email, :username, uniqueness: true
  validates :email, :username, :avatar_url, :password, presence: true
end
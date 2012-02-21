class User < ActiveRecord::Base
  authenticates_with_sorcery!

  has_many :mnemonics
  has_many :votes
  has_many :lists
  
  attr_accessible :email, :name, :password, :password_confirmation
  
  validates_confirmation_of :password
  validates_presence_of :password, :on => :create
  validates_presence_of :email
  validates_uniqueness_of :email
end

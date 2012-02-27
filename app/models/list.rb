class List < ActiveRecord::Base
  has_many :listizations
  has_many :facts, :through => :listizations
  has_many :activities, :dependent => :destroy
  belongs_to :user
end

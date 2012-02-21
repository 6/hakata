class List < ActiveRecord::Base
  has_many :listizations
  has_many :facts, :through => :listizations
  belongs_to :user
end

class Fact < ActiveRecord::Base
  has_many :mnemonics
  has_many :elements
  accepts_nested_attributes_for :mnemonics
  accepts_nested_attributes_for :elements
  has_many :listizations
  has_many :lists, :through => :listizations
  belongs_to :field
end

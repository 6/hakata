class Target < ActiveRecord::Base
  has_many :mnemonics
  has_many :elements
  accepts_nested_attributes_for :mnemonics
  accepts_nested_attributes_for :elements
end

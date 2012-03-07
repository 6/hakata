class Fact < ActiveRecord::Base
  has_many :mnemonics
  has_many :elements
  accepts_nested_attributes_for :mnemonics
  accepts_nested_attributes_for :elements
  has_many :listizations
  has_many :lists, :through => :listizations
  belongs_to :field
  
  def next_in_list(list, listization)
    Fact.find :first,
              :joins => [:lists, :listizations],
              :conditions => ['listizations.position > ? AND listizations.list_id = ?', listization.position, list.id],
              :order => 'listizations.position ASC'
  end
  
  def previous_in_list(list, listization)
    Fact.find :first,
              :joins => [:lists, :listizations],
              :conditions => ['listizations.position < ? AND listizations.list_id = ?', listization.position, list.id],
              :order => 'listizations.position DESC'
  end
end
class List < ActiveRecord::Base
  has_many :listizations
  has_many :facts, :through => :listizations
  has_many :activities, :dependent => :destroy
  belongs_to :user
  
  def greens
    num_greens = 0
    self.facts.each do |f|
      if f.mnemonics.exists?
        num_greens = num_greens + 1
      end
    end
    return num_greens
  end
  
  def greens_percent
    percent = self.greens.to_f/self.facts.count.to_f*100
    return percent.round(1)
  end
end

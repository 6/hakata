class Mnemonic < ActiveRecord::Base
  belongs_to :fact
  belongs_to :user
  has_many :votes
  has_many :activities, :dependent => :destroy
  
  def score
    points = 0
    self.votes.each do |v|
      if v.up then points += 1
      else points -= 1 end
    end
    return points
  end
  
  def user_vote(user)
    user = User.find_by_id(user)
    return Vote.find(:first, :conditions => ['user_id=? AND mnemonic_ID=?', user.id, id])
  end
  
  def user_voted?(current_user, mnemonic)
    vote = Vote.find(:first, :conditions => ['user_id=? AND mnemonic_ID=?', current_user.id, mnemonic.id])
    if vote
      return true
    else
      return false
    end
  end
end

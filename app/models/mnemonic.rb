class Mnemonic < ActiveRecord::Base
  belongs_to :fact
  belongs_to :user
  has_many :votes
  has_many :activities, :dependent => :destroy
  
  def users_vote()
    return Vote.find(:first, :conditions => ['user_id=? AND mnemonic_ID=?', current_user.id, mnemonic.id])
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

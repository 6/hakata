class Activity < ActiveRecord::Base
  belongs_to :user
  belongs_to :list
  belongs_to :mnemonic
  belongs_to :fact
  
  def self.from_users_followed_by(user)
    following_ids = user.following_ids
    where("user_id IN (?) OR user_id = ?", following_ids, user)
  end
  
end

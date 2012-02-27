class Activity < ActiveRecord::Base
  belongs_to :user
  belongs_to :list
  belongs_to :mnemonic
  belongs_to :fact
end

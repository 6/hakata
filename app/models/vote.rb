class Vote < ActiveRecord::Base
  belongs_to :mnemonic
  belongs_to :user
end

class Listization < ActiveRecord::Base
  belongs_to :fact
  belongs_to :list
end

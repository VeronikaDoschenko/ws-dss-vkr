class CritValue < ApplicationRecord
  belongs_to :criterium
  belongs_to :alternative
  belongs_to :crit_scale
end

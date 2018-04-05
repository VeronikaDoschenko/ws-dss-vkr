class Criterium < ApplicationRecord
  belongs_to :task
  belongs_to :criterium
  belongs_to :ws_method
end

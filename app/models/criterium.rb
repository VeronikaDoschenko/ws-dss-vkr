class Criterium < ApplicationRecord
  #include ActsAsTree
  #acts_as_tree
  belongs_to :task
  belongs_to :criterium
  belongs_to :ws_method
  validates :name, :ord, presence: true
  validates :ord, numericality: {only_integer: true}
end

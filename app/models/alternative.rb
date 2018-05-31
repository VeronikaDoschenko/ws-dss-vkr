class Alternative < ApplicationRecord
  belongs_to :task
  validates :name, :rank, presence: true
  validates :rank, numericality: true
end

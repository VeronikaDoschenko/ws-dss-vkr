class AddCriteriumToCritValues < ActiveRecord::Migration[5.1]
  def change
    add_reference :crit_values, :criterium, foreign_key: true
  end
end

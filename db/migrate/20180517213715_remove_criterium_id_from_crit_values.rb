class RemoveCriteriumIdFromCritValues < ActiveRecord::Migration[5.1]
  def change
    remove_reference :crit_values, :criterium_id, foreign_key: true
  end
end

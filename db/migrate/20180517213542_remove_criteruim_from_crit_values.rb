class RemoveCriteruimFromCritValues < ActiveRecord::Migration[5.1]
  def change
    remove_reference :crit_values, :criteruim, foreign_key: true
  end
end

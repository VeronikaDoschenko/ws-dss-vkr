class CreateCritValues < ActiveRecord::Migration[5.1]
  def change
    create_table :crit_values do |t|
      t.references :criteruim, foreign_key: true
      t.references :alternative, foreign_key: true
      t.references :crit_scale, foreign_key: true
      t.decimal :value

      t.timestamps
    end
  end
end

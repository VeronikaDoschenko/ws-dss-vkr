class CreateCritScales < ActiveRecord::Migration[5.1]
  def change
    create_table :crit_scales do |t|
      t.references :criterium, foreign_key: true
      t.string :name
      t.decimal :rank

      t.timestamps
    end
  end
end

class CreateCriteria < ActiveRecord::Migration[5.1]
  def change
    create_table :criteria do |t|
      t.references :task, foreign_key: true
      t.text :description
      t.string :name
      t.references :criterium, foreign_key: true
      t.decimal :rank
      t.integer :ismin
      t.decimal :idealvalue
      t.references :ws_method, foreign_key: true
      t.integer :ord

      t.timestamps
    end
  end
end

class CreateAlternatives < ActiveRecord::Migration[5.1]
  def change
    create_table :alternatives do |t|
      t.references :task, foreign_key: true
      t.string :name
      t.decimal :rank

      t.timestamps
    end
  end
end

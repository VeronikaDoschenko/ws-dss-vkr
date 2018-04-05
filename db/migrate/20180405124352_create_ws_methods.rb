class CreateWsMethods < ActiveRecord::Migration[5.1]
  def change
    create_table :ws_methods do |t|
      t.string :name

      t.timestamps
    end
  end
end

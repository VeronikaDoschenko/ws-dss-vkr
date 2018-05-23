class AddLevelToCriteria < ActiveRecord::Migration[5.1]
  def change
    add_column :criteria, :level, :integer
  end
end

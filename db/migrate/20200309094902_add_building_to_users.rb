class AddBuildingToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :building, :string
  end
end

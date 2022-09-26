class AddHogwartsHouseToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :hogwarts_house, :string
  end
end

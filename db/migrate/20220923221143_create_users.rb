class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.date :birth_date
      t.string :bio
      t.boolean :ARMU

      t.timestamps
    end
  end
end

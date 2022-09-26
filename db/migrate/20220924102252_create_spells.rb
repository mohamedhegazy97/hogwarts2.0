class CreateSpells < ActiveRecord::Migration[6.0]
  def change
    create_table :spells do |t|
      t.text :short_name
      t.string :description
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
    add_index :spells, [:user_id, :created_at]
  end
end

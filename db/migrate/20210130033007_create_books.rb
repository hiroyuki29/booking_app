class CreateBooks < ActiveRecord::Migration[6.1]
  def change
    create_table :books do |t|
      t.date :start_day, null: false
      t.date :end_day, null: false
      t.integer :person_number, null: false
      t.integer :total_cost
      t.references :user, null: false, foreign_key: true
      t.references :room, null: false, foreign_key: true

      t.timestamps
    end
  end
end

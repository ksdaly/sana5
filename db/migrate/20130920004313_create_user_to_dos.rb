class CreateUserToDos < ActiveRecord::Migration
  def change
    create_table :user_to_dos do |t|
      t.integer :user_id, null: false
      t.integer :to_do_id
      t.boolean :completed, default: false
      t.date :day, null: false

      t.timestamps
    end
  end
end

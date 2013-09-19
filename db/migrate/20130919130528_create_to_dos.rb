class CreateToDos < ActiveRecord::Migration
  def change
    create_table :to_dos do |t|
      t.string :title, null: false
      t.text :description, null: false
      t.integer :health_plan_id

      t.timestamps
    end
  end
end

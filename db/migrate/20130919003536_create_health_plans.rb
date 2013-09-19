class CreateHealthPlans < ActiveRecord::Migration
  def change
    create_table :health_plans do |t|
      t.string :title, null: false
      t.string :description, null: false

      t.timestamps
    end
  end
end

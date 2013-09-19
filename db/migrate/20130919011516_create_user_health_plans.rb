class CreateUserHealthPlans < ActiveRecord::Migration
  def change
    create_table :user_health_plans do |t|
      t.integer :user_id, null: false
      t.integer :health_plan_id, null: false

      t.timestamps
    end
  end
end

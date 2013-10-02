class CreateUserHealthPlans < ActiveRecord::Migration
  def change
    create_table :user_health_plans do |t|
      t.integer :user_id, null: false
      t.integer :health_plan_id, null: false

      t.timestamps

      # Add foreign key constraint that health_plan_id is in health_plans.id
    end
  end
end

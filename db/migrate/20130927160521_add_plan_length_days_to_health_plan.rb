class AddPlanLengthDaysToHealthPlan < ActiveRecord::Migration
  def up
    add_column :health_plans, :plan_length_days, :integer
  end

  def down
    remove_column :health_plans, :plan_length_days
  end
end

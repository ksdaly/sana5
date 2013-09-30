class AddStartDateToUserHealthPlans < ActiveRecord::Migration
  def up
    add_column :user_health_plans, :start_date, :date
  end

  def down
    remove_column :user_health_plans, :start_date
  end
end

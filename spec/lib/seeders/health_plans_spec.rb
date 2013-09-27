require 'spec_helper'

describe Seeders::HealthPlans do
  let (:seeder) {Seeders::HealthPlans}

  it 'seeds health plans' do
    seeded_health_plan = seeder.health_plans.first[:title]
    seeder.seed
    expect(HealthPlan.where(title: seeded_health_plan)).to be_present
  end

  it 'does not create duplicates' do
    seeder.seed
    count_after_seed = HealthPlan.count
    seeder.seed
    expect(HealthPlan.count).to  eql(count_after_seed)
  end

end

require 'spec_helper'

describe Seeders::ToDos do
  let (:seeder_health_plans) {Seeders::HealthPlans}
  let (:seeder_to_dos) {Seeders::ToDos}

  it 'seeds to-dos' do
    seeded_to_do = seeder_to_dos.to_dos.first[:title]
    seeder_health_plans.seed
    seeder_to_dos.seed
    expect(ToDo.where(title: seeded_to_do)).to be_present
    expect_multiple_health_plans
  end

  it 'does not create duplicates' do
    seeder_health_plans.seed
    seeder_to_dos.seed
    count_after_seed = ToDo.count
    seeder_to_dos.seed
    expect(ToDo.count).to  eql(count_after_seed)
  end

end

def expect_multiple_health_plans
  HealthPlan.select("id, title").group("id").each do |variable|
    expect(ToDo.where("health_plan_id= ?", variable.id)).to be_present
  end
end



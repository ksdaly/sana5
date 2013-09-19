require 'spec_helper'

describe Seeders::ToDos do
  let (:seeder_health_plans) {Seeders::HealthPlans}
  let (:seeder_to_dos) {Seeders::ToDos}

  it 'seeds to-dos' do
    seeded_to_do = Seeders::ToDos.to_dos.first[:title]
    seeder_health_plans.seed
    seeder_to_dos.seed
    expect(ToDo.where(title: seeded_to_do)).to be_present
  end

  it 'does not create duplicates' do
    seeder_health_plans.seed
    seeder_to_dos.seed
    count_after_seed = ToDo.count
    seeder_to_dos.seed
    expect(ToDo.count).to  eql(count_after_seed)
  end

end



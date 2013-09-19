require 'spec_helper'

describe Seeders::ToDos do
  let (:seeder) {Seeders::ToDos}

  it 'seeds to-dos' do
    seeded_to_do = Seeders::ToDos.to_dos.first[:title]
    seeder.seed
    expect(ToDo.where(title: seeded_to_do)).to be_present
  end

  it 'does not create duplicates' do
    seeder.seed
    count_after_seed = ToDo.count
    seeder.seed
    expect(ToDo.count).to  eql(count_after_seed)
  end

end



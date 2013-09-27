require 'spec_helper'

describe ToDo do

  it {should belong_to(:health_plan)}
  it {should have_many(:users).through(:user_to_dos)}

  it {should have_valid(:title).when('string')}
  it {should_not have_valid(:title).when(nil, '')}
  it {should have_valid(:description).when('string')}
  it {should_not have_valid(:description).when(nil, '')}

end

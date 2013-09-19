require 'spec_helper'

describe UserHealthPlan do

  it {should belong_to(:user)}
  it {should belong_to(:health_plan)}

end

require 'spec_helper'


describe User, focus: true do

  it {should have_many(:health_profiles)}
  it {should have_one(:health_plan).through(:user_health_plan)}
  it {should have_many(:to_dos).through(:user_to_dos)}

  it {should have_valid(:username).when('kate', 'kate_daly', 'kate007')}
  it {should_not have_valid(:username).when(nil, '', 'abcdefghijklmnop', 'kate.daly')}
  it {should have_valid(:email).when('kate@example.com')}
  it {should_not have_valid(:email).when(nil, '', 'kate')}

  it 'has a matching password confirmtion' do
    user = User.new
    user.password = 'password'
    user.password_confirmation = 'anotherpassword'
    expect(user).to_not be_valid
    expect(user.errors[:password_confirmation]).to_not be_blank
  end
end


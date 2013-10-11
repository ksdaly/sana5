require 'spec_helper'

describe UserToDo do

  it {should belong_to(:user)}
  it {should belong_to(:to_do)}

  it {should have_valid(:user)}
  it {should have_valid(:to_do)}

  it {should have_valid(:day).when('2013-09-20')}
  it {should_not have_valid(:day).when(nil, '')}

end

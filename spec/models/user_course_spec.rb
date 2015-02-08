require 'spec_helper'

describe UserCourse do

  it { should belong_to(:course) }
  it { should belong_to(:user) }
  
end
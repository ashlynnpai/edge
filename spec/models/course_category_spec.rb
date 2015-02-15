require 'spec_helper'

describe CourseCategory do

  it { should belong_to(:course) }
  it { should belong_to(:category) }
  
end
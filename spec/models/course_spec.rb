require 'spec_helper'

describe Course do
  it { should validate_presence_of (:name)}
  it { should validate_uniqueness_of (:name)}
  
  it { should have_many(:users) }
  it { should have_many(:reviews) }
end
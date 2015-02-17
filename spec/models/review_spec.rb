require 'spec_helper'

describe Review do
  it { should validate_presence_of (:content)}
  
  it { should belong_to(:course) }
  it { should belong_to(:creator) }
end
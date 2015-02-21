require 'spec_helper'

describe Reply do
  it { should validate_presence_of (:content)}
  
  it { should belong_to(:post) }
  it { should belong_to(:creator) }
end
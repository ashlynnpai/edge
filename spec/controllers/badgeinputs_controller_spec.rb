require 'spec_helper'

describe BadgeinputsController do
  describe 'GET new' do
    it 'sets @badgeinput' do
      get :new
      expect(assigns(:badgeinput)).to be_a_new(Badgeinput)
    end
  end 
end


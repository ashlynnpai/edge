require 'spec_helper'

describe CategoriesController do
  describe 'GET new' do
    it 'sets @category' do
      get :new
      expect(assigns(:category)).to be_a_new(Category)
    end
  end
end
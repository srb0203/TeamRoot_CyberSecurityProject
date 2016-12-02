require 'rails_helper'

RSpec.describe SearchController, type: :controller do
  describe "GET #search" do
    it "successfully renders the search results" do
      expect(controller).to receive(:search) # this line probably of dubious value
      get :search, params: {q: ''}
      expect(response).to be_successful
      expect(response).to render_template(:search)
    end
  end
end

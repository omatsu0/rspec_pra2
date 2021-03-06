require 'rails_helper'

RSpec.describe HomeController, type: :controller do
  describe "#index" do
    #正常にレスポンスを返すこと
    it "responds successfully" do
      get :index
      expect(response).to_not be_success
    end

    it "returns a 200 response" do
      get :index
      expect(response).to have_http_status "200"
    end
  end

end

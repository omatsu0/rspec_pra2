require 'rails_helper'

RSpec.describe "ProjectsApi", type: :request do
  describe "GET /projects_api" do
    it "works! (now write some real specs)" do
      get projects_api_path
      expect(response).to have_http_status(200)
    end
  end

  describe 'Projects API', type: :request do
    # 1件のプロジェクトを読み出すこと
    it 'loads a project' do
      user = FactoryBot.create(:user)
      FactoryBot.create(:project,
        name: "Sample Project")
      FactoryBot.create(:project,
        name: "Second Sample Project",
        owner: user)
      
      get api_projects_path, params: {
        user_email: user.email,
        user_token: user.authentication_token
      }

      expect(response).to have_http_status(:success)
      json = JSON.parse(response.body)
      expect(json.length).to eq 1
      project_id = json[0]["id"]

      get api_project_path(project_id), params: {
        user_email: user.email,
        user_token: user.authentication_token
      }

      expect(response).to have_http_status(:success)
      json = JSON.parse(response.body)
      expect(json["name"]).to eq "Second Sample Project"

    end
end
require "rails_helper"
require 'spec_helper'

describe Admin::ProjectsController, :type => :controller do

  let(:admin) {FactoryGirl.create(:admin_user)}
  let(:project_1){FactoryGirl.create(:project)}
  let(:project_2){FactoryGirl.create(:project)}

  let(:valid_project_params) { {project: FactoryGirl.build(:project).as_json} }
  let(:invalid_project_params) { {project: {}} }


  context "new" do
    it "should display the form" do
      get :new, {}, {id: admin.q_auth_uid}
      expect(response.status).to eq(200)

      xhr :get, :new, {}, {id: admin.q_auth_uid}
      expect(assigns(:project)).to be_a Project
    end
  end

  context "create" do
    it "positive case" do
      xhr :post, :create, valid_project_params, {id: admin.q_auth_uid}
      expect(Project.count).to  eq 1
      expect(response.code).to eq("200")
    end

    it "negative case" do
      xhr :post, :create, invalid_project_params, {id: admin.q_auth_uid}
      expect(Project.count).to  eq 0
      expect(response.code).to eq("200")
    end
  end

  context "edit" do
    it "should display the form" do
      get :edit, {id: project_1.id}, {id: admin.q_auth_uid}
      expect(assigns[:project]).to eq(project_1)
      expect(response.status).to eq(200)

      xhr :get, :edit, {id: project_1.id}, {id: admin.q_auth_uid}
      expect(assigns(:project)).to eq(project_1)
      expect(response.code).to eq("200")
    end
  end

  context "update" do
    it "positive case" do
      xhr :put, :update, {id: project_1.id, project: project_1.as_json.merge!({"name" =>  "Updated project Name"})}, {id: admin.q_auth_uid}
      expect(assigns(:project).errors.any?).to eq(false)
      expect(assigns(:project).name).to  eq("Updated project Name")
      expect(Project.count).to  eq 1
      expect(response.code).to eq("200")
    end

    it "negative case" do
      xhr :put, :update, {id: project_1.id, project: project_1.as_json.merge!({"name" =>  ""})}, {id: admin.q_auth_uid}
      expect(assigns(:project).errors.any?).to eq(true)
      expect(Project.count).to  eq 1
      expect(response.code).to eq("200")
    end
  end

  context "index" do
    it "should return the projects details" do
      [project_1, project_2]
      get :index, {}, {id: admin.q_auth_uid}
      expect(assigns[:projects]).to match_array([project_1,project_2])
      expect(response.status).to eq(200)

      xhr :get, :index, {}, {id: admin.q_auth_uid}
      expect(assigns[:projects]).to match_array([project_1,project_2])
      expect(response.code).to eq("200")
    end
  end

  context "destroy" do
    it "should remove the project" do
      [project_1, project_2]
      xhr :delete, :destroy, {id: project_1.id}, {id: admin.q_auth_uid}
      expect(Project.count).to  eq 1
      expect(response.code).to eq("200")
    end
  end


end
require "rails_helper"
require 'spec_helper'

describe Admin::LinkTypesController, :type => :controller do

  let(:admin) {FactoryGirl.create(:admin_user)}
  let(:link_type_1){FactoryGirl.create(:link_type)}
  let(:link_type_2){FactoryGirl.create(:link_type)}

  let(:valid_link_type_params) { {link_type: FactoryGirl.build(:link_type).as_json} }
  let(:invalid_link_type_params) { {link_type: {}} }


  context "new" do
    it "should display the form" do
      get :new, {}, {id: admin.q_auth_uid}
      expect(response.status).to eq(200)

      xhr :get, :new, {}, {id: admin.q_auth_uid}
      expect(assigns(:link_type)).to be_a LinkType
    end
  end

  context "create" do
    it "positive case" do
      xhr :post, :create, valid_link_type_params, {id: admin.q_auth_uid}
      expect(LinkType.count).to  eq 1
      expect(response.code).to eq("200")
    end

    it "negative case" do
      xhr :post, :create, invalid_link_type_params, {id: admin.q_auth_uid}
      expect(LinkType.count).to  eq 0
      expect(response.code).to eq("200")
    end
  end

  context "edit" do
    it "should display the form" do
      get :edit, {id: link_type_1.id}, {id: admin.q_auth_uid}
      expect(assigns[:link_type]).to eq(link_type_1)
      expect(response.status).to eq(200)

      xhr :get, :edit, {id: link_type_1.id}, {id: admin.q_auth_uid}
      expect(assigns(:link_type)).to eq(link_type_1)
      expect(response.code).to eq("200")
    end
  end

  context "update" do
    it "positive case" do
      xhr :put, :update, {id: link_type_1.id, link_type: link_type_1.as_json.merge!({"name" =>  "Updated link_type Name"})}, {id: admin.q_auth_uid}
      expect(assigns(:link_type).errors.any?).to eq(false)
      expect(assigns(:link_type).name).to  eq("Updated link_type Name")
      expect(LinkType.count).to  eq 1
      expect(response.code).to eq("200")
    end

    it "negative case" do
      xhr :put, :update, {id: link_type_1.id, link_type: link_type_1.as_json.merge!({"name" =>  ""})}, {id: admin.q_auth_uid}
      expect(assigns(:link_type).errors.any?).to eq(true)
      expect(LinkType.count).to  eq 1
      expect(response.code).to eq("200")
    end
  end

  context "index" do
    it "should return the link type details" do
      [link_type_1, link_type_2]
      get :index, {}, {id: admin.q_auth_uid}
      expect(assigns[:link_types]).to match_array([link_type_1,link_type_2])
      expect(response.status).to eq(200)

      xhr :get, :index, {}, {id: admin.q_auth_uid}
      expect(assigns[:link_types]).to match_array([link_type_1,link_type_2])
      expect(response.code).to eq("200")
    end
  end

  context "show" do
    it "should return the specific link type" do
      get :show, {:id => link_type_1.id}, {id: admin.q_auth_uid}
      expect(assigns[:link_type]).to eq(link_type_1)
      expect(assigns[:link_types]).to match_array([link_type_1,link_type_2])
      expect(response.status).to eq(200)

      xhr :get, :show, {id: link_type_1.id}, {id: admin.q_auth_uid}
      expect(assigns[:link_type]).to eq(link_type_1)
      expect(response.code).to eq("200")
    end
  end

  context "destroy" do
    it "should remove the link type" do
      [link_type_1, link_type_2]
      xhr :delete, :destroy, {id: link_type_1.id}, {id: admin.q_auth_uid}
      expect(LinkType.count).to  eq 1
      expect(response.code).to eq("200")
    end
  end
end
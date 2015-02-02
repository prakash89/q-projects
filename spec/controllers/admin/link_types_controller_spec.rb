require "rails_helper"
require 'spec_helper'

describe Admin::LinkTypesController, :type => :controller do

  let(:admin) {FactoryGirl.create(:admin_user)}
  let(:link_type){FactoryGirl.create(:link_type)}
  let(:link_type_1){FactoryGirl.create(:link_type)}
  let(:link_type_2){FactoryGirl.create(:link_type)}


  it "POST #create" do
    link_type_params = {
      link_type: {
        name: "Client namer",
        description: "Client Description",
        button_text: "button_text"
      }
    }
    post :create, link_type_params, {id: admin.id}
    expect(LinkType.count).to  eq 1
  end

  it "GET #index" do
    [link_type_1,link_type_2]
    get :index, nil, {id: admin.id}
    expect(assigns[:link_types]).to match_array([link_type_1,link_type_2])
  end

  it "GET #show" do
    get :show, {:id => link_type.id}, {id: admin.id}
    expect(assigns(:link_type)).to eq(link_type)
  end

  it "GET #edit" do
   get :edit, {id: link_type.id}, {id: admin.id}
   expect(assigns[:link_type]).to eq(link_type)
  end

  it "PUT #update" do
    put :update, {:id => link_type.id, :link_type => { :name => "Updated title", :description =>"Tested data",:city =>"city"}}, {id: admin.id}
    expect(assigns(:link_type)).to eq(link_type)
  end

  describe "DELETE #destroy" do
    it "admin should be able to destroy the link_type" do
      expect do
        delete :destroy, {:id => link_type.to_param}, {id: admin.id}
        expect(LinkType.count).to  eq 1
      end
    end
  end




end
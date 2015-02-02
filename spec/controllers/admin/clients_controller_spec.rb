require "rails_helper"
require 'spec_helper'

describe Admin::ClientsController, :type => :controller do

  let(:admin) {FactoryGirl.create(:admin_user)}
  let(:client){FactoryGirl.create(:client)}
  let(:client_1){FactoryGirl.create(:client)}
  let(:client_2){FactoryGirl.create(:client)}


  it "POST #create" do
    client_params = {
      client: {
        name: "Client namer",
        description: "Client Description",
        city: "city",
        state: "state",
        country: "country",
        pretty_url: "http://www.google.com"
      }
    }
    post :create, client_params, {id: admin.id}
    expect(Client.count).to  eq 1
  end

  it "GET #index" do
    [client_1,client_2]
    get :index, nil, {id: admin.id}
    expect(assigns[:clients]).to match_array([client_1,client_2])
  end

  it "GET #show" do
    get :show, {:id => client.id}, {id: admin.id}
    expect(assigns(:client)).to eq(client)
  end

  it "GET #edit" do
   get :edit, {id: client.id}, {id: admin.id}
   expect(assigns[:client]).to eq(client)
  end

  it "PUT #update" do
    put :update, {:id => client.id, :client => { :name => "New title", :description =>"Tested data",:city =>"city",:state =>"state",:country =>"country",:pretty_url =>"http://www.google.com"}}, {id: admin.id}
    expect(assigns(:client)).to eq(client)
  end

  describe "DELETE #destroy" do
    it "admin should be able to destroy the client" do
      expect do
        delete :destroy, {:id => client.to_param}, {id: admin.id}
        expect(Client.count).to  eq 1
      end
    end
  end


end
require "rails_helper"

describe Admin::ClientsController, :type => :controller do

  let(:admin) {FactoryGirl.create(:admin_user)}
  let(:client_1){FactoryGirl.create(:client)}
  let(:client_2){FactoryGirl.create(:client)}

  let(:valid_client_params) { {client: FactoryGirl.build(:client).as_json} }
  let(:invalid_client_params) { {client: {}} }

  context "index" do
    it "should return the list of clients" do
      [client_1, client_2]
      get :index, {}, {id: admin.q_auth_uid}
      expect(assigns[:clients]).to match_array([client_1,client_2])
      expect(response.status).to eq(200)

      xhr :get, :index, {}, {id: admin.q_auth_uid}
      expect(assigns[:clients]).to match_array([client_1,client_2])
      expect(response.code).to eq("200")
    end
  end

  context "show" do
    it "should return a specific client" do
      get :show, {:id => client_1.id}, {id: admin.q_auth_uid}
      expect(assigns[:client]).to eq(client_1)
      expect(assigns[:clients]).to match_array([client_1,client_2])
      expect(response.status).to eq(200)

      xhr :get, :show, {id: client_1.id}, {id: admin.q_auth_uid}
      expect(assigns[:client]).to eq(client_1)
      expect(response.code).to eq("200")
    end
  end

  context "new" do
    it "should display the form" do
      get :new, {}, {id: admin.q_auth_uid}
      expect(assigns[:clients]).to match_array([client_1,client_2])
      expect(response.status).to eq(200)

      xhr :get, :new, {}, {id: admin.q_auth_uid}
      expect(assigns(:client)).to be_a Client
    end
  end

  context "create" do
    it "positive case" do
      xhr :post, :create, valid_client_params, {id: admin.q_auth_uid}
      expect(Client.count).to  eq 1
      expect(response.code).to eq("200")
    end

    it "negative case" do
      xhr :post, :create, invalid_client_params, {id: admin.q_auth_uid}
      expect(Client.count).to  eq 0
      expect(response.code).to eq("200")
    end
  end

  context "edit" do
    it "should display the form" do
      get :edit, {id: client_1.id}, {id: admin.q_auth_uid}
      expect(assigns[:client]).to eq(client_1)
      expect(response.status).to eq(200)

      xhr :get, :edit, {id: client_1.id}, {id: admin.q_auth_uid}
      expect(assigns(:client)).to eq(client_1)
      expect(response.code).to eq("200")
    end
  end

  context "update" do
    it "positive case" do
      xhr :put, :update, {id: client_1.id, client: client_1.as_json.merge!({"name" =>  "Updated Client Name"})}, {id: admin.q_auth_uid}
      expect(assigns(:client).errors.any?).to eq(false)
      expect(assigns(:client).name).to  eq("Updated Client Name")
      expect(Client.count).to  eq 1
      expect(response.code).to eq("200")
    end

    it "negative case" do
      xhr :put, :update, {id: client_1.id, client: client_1.as_json.merge!({"name" =>  ""})}, {id: admin.q_auth_uid}
      expect(assigns(:client).errors.any?).to eq(true)
      expect(Client.count).to  eq 1
      expect(response.code).to eq("200")
    end
  end

  context "destroy" do
    it "should remove the client" do
      [client_1, client_2]
      xhr :delete, :destroy, {id: client_1.id}, {id: admin.q_auth_uid}
      expect(Client.count).to  eq 1
      expect(response.code).to eq("200")
    end
  end

end
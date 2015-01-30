require 'rails_helper'

RSpec.describe Client, :type => :model do

  let(:client1) {FactoryGirl.create(:client, name: "Small Apple", description: "Big Banana", city: "Rock Garden")}
  let(:client2) {FactoryGirl.create(:client, name: "Big Mango", description: "Small Banana", city: "Pebble Garden")}
  let(:client3) {FactoryGirl.create(:client, name: "Pine Apple", state: "Monkey", country: "Donkey")}

  context "Factory" do
    it "should validate the client factory" do
      expect(FactoryGirl.build(:client).valid?).to be true
    end
  end

  context "Validations" do
    it { should validate_presence_of :name }
    it { should allow_value('Dish World').for(:name )}
    it { should_not allow_value('AB').for(:name )}

    it { should allow_value("xasd "*400).for(:description )}
    it { should_not allow_value("x"*2051).for(:description )}
    it { should_not allow_value('AB').for(:description )}

    it { should allow_value("http://google.com").for(:pretty_url )}
    it { should allow_value("https://google.com").for(:pretty_url )}
    it { should allow_value("https://www.google.com").for(:pretty_url )}
    it { should allow_value("google.com").for(:pretty_url )}
    it { should_not allow_value("x"*511).for(:pretty_url )}
    it { should_not allow_value('google').for(:pretty_url )}

    it { should allow_value(nil).for(:pretty_url )}
    it { should allow_value("").for(:pretty_url )}
  end

  context "Associations" do
    it { should have_many(:projects) }
    it { should have_many(:users) }
    it { should have_one(:logo) }
  end

  context "Class Methods" do
    it "should search clients for a query string" do
      [client1,client2,client3]
      expect(Client.search("Apple")).to match_array([client1,client3])
      expect(Client.search("Mango")).to match_array([client2])
      expect(Client.search("Banana")).to match_array([client1, client2])
      expect(Client.search("Big")).to match_array([client1, client2])
      expect(Client.search("Rock Garden")).to match_array([client1])
      expect(Client.search("Garden")).to match_array([client1, client2])
      expect(Client.search("Monkey")).to match_array([client3])
      expect(Client.search("Donkey")).to match_array([client3])
    end
  end

  context "Instance Methods" do
    it "should return the address ready to display" do
      client1 = Client.new(name: "Client Name", city: "Mysore")
      client2 = Client.new(name: "Client Name", state: "Karnataka")
      client3 = Client.new(name: "Client Name", country: "India")
      client4 = Client.new(name: "Client Name", city: "Mysore", state: "Karnataka")
      client5 = Client.new(name: "Client Name", city: "Mysore", country: "India")
      client6 = Client.new(name: "Client Name", state: "Karnataka", country: "India")
      client7 = Client.new(name: "Client Name", city: "Mysore", state: "Karnataka", country: "India")

      expect(client1.display_address).to eq "Mysore"
      expect(client2.display_address).to eq "Karnataka"
      expect(client3.display_address).to eq "India"
      expect(client4.display_address).to eq "Mysore, Karnataka"
      expect(client5.display_address).to eq "Mysore, India"
      expect(client6.display_address).to eq "Karnataka, India"
      expect(client7.display_address).to eq "Mysore, Karnataka, India"
    end
  end

end
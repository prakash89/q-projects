require 'rails_helper'

RSpec.describe LinkType, :type => :model do

  let(:link_type1) {FactoryGirl.create(:link_type, name: "Apple", description: "Big Banana")}
  let(:link_type2) {FactoryGirl.create(:link_type, name: "Mango", description: "Small Banana")}
  let(:link_type3) {FactoryGirl.create(:link_type, name: "Pine Apple", description: "Mango Bite")}

  context "Factory settings for link_type" do
    it "should validate the link_type factory" do
      expect(FactoryGirl.build(:link_type).valid?).to be true
    end
  end

  context "Validations" do
    it { should validate_presence_of :name }
    it { should allow_value('Dish World').for(:name )}
    it { should_not allow_value('AB').for(:name )}

    it { should allow_value("xasd "*400).for(:description )}
    it { should_not allow_value("x"*2051).for(:description )}
    it { should_not allow_value('AB').for(:description )}
  end

  context "Associations" do
    it { should have_many(:project_links) }
    it { should have_one(:picture) }
  end

  context "Class Methods" do
    it "should search link types for a query string" do
      [link_type1,link_type2,link_type3]
      expect(LinkType.search("Apple")).to match_array([link_type1,link_type3])
      expect(LinkType.search("Pine Apple")).to match_array([link_type3])
      expect(LinkType.search("Mango")).to match_array([link_type2, link_type3])
      expect(LinkType.search("Banana")).to match_array([link_type1, link_type2])
    end
  end

end
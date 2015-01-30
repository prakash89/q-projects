require 'rails_helper'

RSpec.describe ProjectLink, :type => :model do

  context "Factory" do
    it "should validate the project link factory" do
      expect(FactoryGirl.build(:project_link).valid?).to be true
    end
  end

  context "Validations" do
    it { should allow_value("http://google.com").for(:url )}
    it { should allow_value("https://google.com").for(:url )}
    it { should allow_value("https://www.google.com").for(:url )}
    it { should allow_value("google.com").for(:url )}
    it { should_not allow_value("x"*511).for(:url )}
    it { should_not allow_value('google').for(:url )}
  end

  context "Associations" do
    it { should belong_to(:project) }
    it { should belong_to(:link_type) }
  end

end
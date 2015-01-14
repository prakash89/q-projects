require 'rails_helper'

RSpec.describe LinkType, :type => :model do

  context "Factory settings for link_type" do
    it "should validate the link_type factory" do
      expect(FactoryGirl.build(:link_type).valid?).to be true
    end
  end

end
require 'rails_helper'

RSpec.describe Client, :type => :model do

  context "Factory settings for client" do
    it "should validate the client factory" do
      expect(FactoryGirl.build(:client).valid?).to be true
    end
  end

end
require 'rails_helper'

RSpec.describe Project, :type => :model do

  context "Factory settings for project" do
    it "should validate the project factory" do
      expect(FactoryGirl.build(:project).valid?).to be true
    end
  end

end
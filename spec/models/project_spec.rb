require 'rails_helper'

RSpec.describe Project, :type => :model do

  let(:user1) {FactoryGirl.create(:normal_user)}
  let(:user2) {FactoryGirl.create(:normal_user)}
  let(:project1) {FactoryGirl.create(:project, name: "Apple", description: "Big Banana")}
  let(:project2) {FactoryGirl.create(:project, name: "Mango", description: "Small Banana")}
  let(:project3) {FactoryGirl.create(:project, name: "Pine Apple", description: "Mango Bite")}
  let(:link_type1) {FactoryGirl.create(:link_type, name: "Github", button_text: "Open Github")}
  let(:link_type2) {FactoryGirl.create(:link_type, name: "JIRA", button_text: "Launch JIRA")}

  context "Factory settings for project" do
    it "should validate the project factory" do
      expect(FactoryGirl.build(:project).valid?).to be true
    end
  end

  context "Validations" do
    it { should validate_presence_of :name }
    it { should allow_value('New Project').for(:name )}
    it { should_not allow_value('A').for(:name )}

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
    it { should allow_value('').for(:pretty_url )}
  end

  context "Associations" do
    it { should belong_to(:client) }
    it { should have_many(:project_links) }
    it { should have_many(:roles) }
    it { should have_many(:users) }
    it { should have_one(:logo) }
  end

  context "Class Methods" do
    it "should search projects for a query string" do
      [project1,project2,project3]
      expect(Project.search("Apple")).to match_array([project1,project3])
      expect(Project.search("Pine Apple")).to match_array([project3])
      expect(Project.search("Mango")).to match_array([project2, project3])
      expect(Project.search("Banana")).to match_array([project1, project2])
    end
  end

  context "Instance Methods" do
    it "should add and remove roles" do
      [user1, user2]
      expect(User.count).to eq(2)
      expect(Role.count).to eq(0)

      role1 = project1.add_role(user1, "Scrum Master")
      role2 = project1.add_role(user2, "Scrum Team Member")
      expect(project1.roles).to match_array([role1, role2])

      project1.remove_role(role1)
      expect(project1.roles).to match_array([role2])

      expect(User.count).to eq(2)
      expect(Role.count).to eq(1)
    end

    it "should add and remove project links" do
      [link_type1, link_type2]
      expect(LinkType.count).to eq(2)
      expect(ProjectLink.count).to eq(0)

      project_link1 = project1.add_link(link_type1, "www.github.com", true)
      project_link2 = project1.add_link(link_type2, "domain.jira.com", false)
      expect(project1.project_links).to match_array([project_link1, project_link2])

      project1.remove_link(project_link1)
      expect(project1.project_links).to match_array([project_link2])

      expect(LinkType.count).to eq(2)
      expect(ProjectLink.count).to eq(1)
    end
  end

end
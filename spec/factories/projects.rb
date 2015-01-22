FactoryGirl.define do
  factory :project do
    name "Project Name"
    description "Project description"
    pretty_url "www.google.com"
    client
  end
end
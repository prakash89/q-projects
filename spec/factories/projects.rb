FactoryGirl.define do
  factory :project do
    name "Project name"
    description "Project description"
    pretty_url "www.google.com"
    client
  end
end
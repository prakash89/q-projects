FactoryGirl.define do
  factory :project do
    name "Project Name"
    description "Project Description"
    pretty_url "http://www.google.com"
    client
  end
end
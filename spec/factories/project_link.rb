FactoryGirl.define do
  factory :project_link do
    link_type
    project
    url "http://google.com"
    under_construction false
  end
end
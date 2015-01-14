FactoryGirl.define do
  factory :client do
    name "Client name"
    description "client description"
    city "city"
    state "state"
    country "country"
    pretty_url "www.google.com"
  end
end
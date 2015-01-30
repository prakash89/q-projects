FactoryGirl.define do
  factory :client do
    name "Client name"
    description "Client Description"
    city "city"
    state "state"
    country "country"
    pretty_url "http://www.google.com"
  end
end